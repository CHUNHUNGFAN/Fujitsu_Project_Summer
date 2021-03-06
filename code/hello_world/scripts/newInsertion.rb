# Objective:
#   register raw data and index
#
# Creater: Chun-Hung Fan
# Latest Update: 2018.08.10 14:58

require 'httpclient'
require 'json'
require 'yaml'

client = HTTPClient.new

config = YAML.load_file('newConfig.yml')
# Ref. https://stackoverflow.com/questions/21422494/reading-and-updating-yaml-file-by-ruby-code
fed = config['fed']

base_uri = 'http://' + fed + ':30013'

# raw-data registration
api = '/sink_agent/api/rawdata'
header = { 'Content-type' => 'application/octet-stream' }
uri = base_uri + api
body = open( './news.json' , 'r' )

# register the raw-data to sink-agent
res = client.post(uri, body, header)
# index registration
if res.code != 200
    # if error presented
    puts res.body
    puts "Raw data registration failed with code: " + res.code
    exit!
end

puts "Raw data registration succeed, begin index registration......"

api = '/sink_agent/api/put_idx'
header = { 'Content-type' => 'application/json' }
uri = base_uri + api
# retrieve the data_id generated by the sink-agent
jsonResult = JSON.parse( res.body )
data_id = jsonResult['data_id']

payload = Hash.new
payload[:sink_info] = {:data_id => data_id}
payload[:dir_keys] = ["location", "device_id"]
payload[:meta] = {
    :location => config['location'],
    :device_id => config['device_id']
}
payload[:gen_time] = Time.now.to_i

res = client.post(uri, payload.to_json, header)
puts "code=#{res.code}"
puts res.body