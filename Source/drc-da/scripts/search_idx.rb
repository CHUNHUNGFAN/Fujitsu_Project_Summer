require 'httpclient'
require 'json'

client = HTTPClient.new

base_uri = 'http://xxx.xxx.xxx.xxx:30013'
resource_path = '/sink_agent/api/search_idx'
header = { 'Content-type' => 'application/json' }
payload = {'idx_id' => 'UUID'}
uri = base_uri + resource_path
  
  
res = client.post(uri, payload.to_json, header)
puts "code=#{res.code}"
puts res.body


