require 'httpclient'
require 'json'
require 'yaml'

client = HTTPClient.new
config = YAML.load_file('config.yml')
target = config['target']

# base_uri = 'http://xxx.xxx.xxx.xxx:30013'
base_uri = 'http://' + target + ':30013'

resource_path = '/sink_agent/api/search_idx'
header = { 'Content-type' => 'application/json' }
payload = {'idx_id' => 'UUID'}
uri = base_uri + resource_path
  
  
res = client.post(uri, payload.to_json, header)
puts "code=#{res.code}"
puts res.body
