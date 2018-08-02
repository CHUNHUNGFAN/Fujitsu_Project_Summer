require 'mqtt'
require 'json'
require 'securerandom'

class IoTDAClient

  def initialize(host: nil, port: nil)
    @host = host
    @port = port
    @conn = MQTT::Client.connect(:host => @host, :port => @port, :keep_alive => 60)
  end

  def publish_idx_v2(sink_info: nil, dir_keys: nil, meta: nil, gen_time: nil, queue_name: nil)

    topic = "drc-da/input/index-key/#{queue_name}"

    payload = Hash.new
    payload[:sink_info] = sink_info
    payload[:dir_keys] = dir_keys
    payload[:meta] = meta
    payload[:gen_time] = gen_time if !gen_time.nil?

    @conn.publish(topic, payload.to_json)
    puts "[x] Sent 'Topic: #{topic}, Payload: #{payload.to_json}'"

  end

  def search_idx_v2(search_keyvalue: nil, callback: nil, queue_name: nil)

    topic = "drc-da/output/index-key/#{queue_name}"

    payload = search_keyvalue

    @conn.publish(topic, payload.to_json)
    puts "[x] Sent 'Topic: #{topic}, Payload: #{payload.to_json}'"

  end

  def subscribe(node_id: nil, subscribe_keys: nil, ts_gt: nil, ts_lt: nil, callback: nil, timeout: 10)
    queue_name = SecureRandom.uuid.to_s

    topic = "drc-da/output/set-subscription/#{queue_name}"

    if !ts_gt.nil? || !ts_lt.nil?
      subscribe_keys[:timestamp_sys] = Hash.new
      subscribe_keys[:timestamp_sys]['$gt'] = ts_gt if !ts_gt.nil?
      subscribe_keys[:timestamp_sys]['$gt'] = ts_lt if !ts_lt.nil?
    end

    @conn.publish(topic, subscribe_keys.to_json)
    puts "[x] Sent 'Topic: #{topic}, Payload: #{subscribe_keys.to_json}'"

    response = nil
    @conn.get("drc-da/response/#{queue_name}") do |topic, message|
      puts "[x] Received '#{message}'"
      response = message
      break
    end

    return response
  end

  def close()
    @conn.close
  end

  def subscribe_queue(queue_name: nil, search_keyvalue: nil)

    t = Thread.new() do
      get_pub_res = GetResponseThread.new(host: @host, port: @port, queue_name: queue_name, search_keyvalue: search_keyvalue)
      get_pub_res.run
    end

  end

end
$num = 0

class GetResponseThread

  def initialize(host: nil, port: nil, queue_name: nil, search_keyvalue: nil)
    @host = host
    @port = port
    @conn = MQTT::Client.connect(:host => @host, :port => @port)
    @queue_name = queue_name
    @search_keyvalue = search_keyvalue
  end
  
  def run()
    response = nil
    @conn.get("drc-da/response/#{@queue_name}") do |topic, message|
      puts "[x] Received '#{message}'"
      response = message

      res_hash = JSON.parse(response)
      if res_hash.size==0 then
        puts "response is empty."
        exit 1;
      end
      puts res_hash

      if res_hash.include?("result") then
        if res_hash["result"] then
          puts "[x] Put index success."

        else
          puts "[x] Put index fail."
          exit 1;
        end

      else

        if @search_keyvalue==nil then
          return false
        end
        skj_hash = JSON.parse(@search_keyvalue.to_json)
        
        flag = true      
        skj_hash.each do |skj_key, skj_val|

          res_hash.each do |res_val|
            if skj_val == res_val[skj_key] then
              
            else
              kj_hash = JSON.parse(skj_val.to_json)
              kj_hash.each do |kj_key, kj_val|
                if JSON.parse(res_val[skj_key].to_json)[kj_key] then
                  
                else
                  flag = false
                end
              end
            end
          end
        end

        if(!flag)
          puts "[x] Invalid index."
          exit 1;
        end
      end
      $num += 1
    end
  end

end
