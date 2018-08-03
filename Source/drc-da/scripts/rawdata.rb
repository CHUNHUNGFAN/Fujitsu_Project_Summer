require 'httpclient'
require 'json'

client = HTTPClient.new

base_uri = 'http://xxx.xxx.xxx.xxx:30013'
resource_path = '/sink_agent/api/rawdata'
header = { 'Content-type' => 'application/octet-stream' }
uri = base_uri + resource_path
body = open('{path_to_file}/{file_name}','r')
  
res = client.post(uri, body, header)
puts "code=#{res.code}"
puts res.body


