require 'httpclient'
require 'json'

client = HTTPClient.new

base_uri = 'http://xxx.xxx.xxx.xxx:30013'
resource_path = '/sink_agent/api/rawdata/'
data_id = "UUID"
header = { 'Content-type' => 'application/json' }
uri = base_uri + resource_path + data_id
  
res = client.get(uri, header)
puts "code=#{res.code}"
puts res.body
