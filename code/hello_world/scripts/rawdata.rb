require 'httpclient'
require 'json'
require 'yaml'

client = HTTPClient.new
config = YAML.load_file('config.yml')
target = config['target']

# base_uri = 'http://xxx.xxx.xxx.xxx:30013'
base_uri = 'http://' + target + ':30013'

resource_path = '/sink_agent/api/rawdata'
header = { 'Content-type' => 'application/octet-stream' }
uri = base_uri + resource_path
body = open('{path_to_file}/{file_name}','r')
  
res = client.post(uri, body, header)
puts "code=#{res.code}"
puts res.body
