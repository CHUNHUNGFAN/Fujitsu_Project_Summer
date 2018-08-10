require 'httpclient'
require 'json'
require 'yaml'

client = HTTPClient.new
# Ref. https://stackoverflow.com/questions/21422494/reading-and-updating-yaml-file-by-ruby-code
config = YAML.load_file('config.yml')
loc = config['location']

#Set the IP address of the destination of index registration request
# base_uri = 'http://xxx.xxx.xxx.xxx:30013'
base_uri = 'https://api.sys3.iot.jp.fujitsu.com/v1/VTB003-001/testbeddir/'

key = 'keyvalues/'

resource_path = 'raw_entries/'

searchkey = 'device_id/'

header = { 'Authorization': 'Bearer testbeddirTokyo'}

# uri = base_uri + resource_path + '_past?$filter=gen_time%20gt%20%271533867180%27'
uri = base_uri + key + searchkey + '_past?$filter=gen_time%20gt%201533867180'

res = client.get(uri,nil,header)

puts uri
puts res

puts "code=#{res.code}"
puts res.body
