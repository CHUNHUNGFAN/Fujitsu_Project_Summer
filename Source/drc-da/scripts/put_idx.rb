require 'httpclient'
require 'json'

client = HTTPClient.new

base_uri = 'http://xxx.xxx.xxx.xxx:30013'

resource_path = '/sink_agent/api/put_idx'
header = { 'Content-type' => 'application/json' }
uri = base_uri + resource_path
data_id = "UUID"

payload = Hash.new
payload[:sink_info] = {:data_id => data_id}
payload[:dir_keys] = ["location","device_id"]
payload[:meta] = {:location => "loc-A", :device_id => "dev-01", :temp => 25.5, :humid => 60}
payload[:gen_time] = Time.now.to_i

  
res = client.post(uri, payload.to_json, header)
puts "code=#{res.code}"
puts res.body


