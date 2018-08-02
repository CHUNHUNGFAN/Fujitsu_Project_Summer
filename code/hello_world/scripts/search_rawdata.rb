require 'httpclient'
require 'json'
require 'yaml'

client = HTTPClient.new
config = YAML.load_file('config.yml')
target = config['target']

# base_uri = 'http://xxx.xxx.xxx.xxx:30013'
base_uri = 'http://' + target + ':30013'

resource_path = '/sink_agent/api/rawdata/'
data_id = "UUID"
header = { 'Content-type' => 'application/json' }
uri = base_uri + resource_path + data_id
  
res = client.get(uri, header)
puts "code=#{res.code}"
puts res.body
