require 'httpclient'
require 'json'
require 'yaml'

client = HTTPClient.new
# Ref. https://stackoverflow.com/questions/21422494/reading-and-updating-yaml-file-by-ruby-code
config = YAML.load_file('config.yml')
fed = config['fed']

# base_uri = 'http://xxx.xxx.xxx.xxx:30013'
base_uri = 'http://' + fed + ':30013'

resource_path = '/sink_agent/api/put_idx'
header = { 'Content-type' => 'application/json' }
uri = base_uri + resource_path
# data_id = "UUID"
data_id = "041c5476-d1e4-4f29-b385-bb583c86b0ef"
# [ucdavis@hippos-fed]$ ruby insertion.rb
#   code=200
#   {"result":true,"data_id":"041c5476-d1e4-4f29-b385-bb583c86b0ef"}
# [ucdavis@hippos-fed]$ date
#   Fri Jul 27 14:54:45 PDT 2018

payload = Hash.new
payload[:sink_info] = {:data_id => data_id}
payload[:dir_keys] = ["location", "device_id"]
payload[:meta] = {
    :location => config['location'],
    :device_id => config['device_id'],
    :temp => 25.5,
    :humid => 60
}
payload[:gen_time] = Time.now.to_i

res = client.post(uri, payload.to_json, header)
puts "code=#{res.code}"
puts res.body
# [ucdavis@hippos-fed]$ ruby put_idx.rb
#   code=200
#   {"result":false,"idx_id":null}
# [ucdavis@hippos-fed]$ date
#   Fri Jul 27 14:55:48 PDT 2018
