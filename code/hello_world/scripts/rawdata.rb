#Import of required libraries (described in all scripts)
require 'httpclient'
require 'json'
require 'yaml'

client = HTTPClient.new
config = YAML.load_file('config.yml')
fed = config['fed']

# Set the IP address of raw data registration 
# base_uri = 'http://xxx.xxx.xxx.xxx:30013'
base_uri = 'http://' + fed + ':30013'

resource_path = '/sink_agent/api/rawdata'
header = { 'Content-type' => 'application/octet-stream' }
uri = base_uri + resource_path

#In the following example, a file is registered as a raw data
#body = open('{path_to_file}/{file_name}','r') 
body = open('./test_data.json','r')
res = client.post(uri, body, header)

#Acquire response (data_id) at raw data registration
puts "code=#{res.code}"
puts res.body

#[ucdavis@localhost scripts]$ ruby rawdata.rb                                                                                                  
#code=200
#{"result":true,"data_id":"4332579a-1762-4af9-81a7-a762be3f0f4e"}
#[ucdavis@localhost scripts]$ date
#Thu Aug  2 16:58:19 PDT 2018

#[ucdavis@localhost scripts]$ ruby rawdata.rb
#code=200
#{"result":true,"data_id":"fa5c761b-e45c-4a00-b076-a7278c8463ec"}
#[ucdavis@localhost scripts]$ date
#Sun Aug  5 10:28:00 PDT 2018