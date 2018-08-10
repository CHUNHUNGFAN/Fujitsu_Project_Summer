require 'httpclient'
require 'json'
require 'yaml'

client = HTTPClient.new
# Ref. https://stackoverflow.com/questions/21422494/reading-and-updating-yaml-file-by-ruby-code
config = YAML.load_file('config.yml')
fed = config['fed']

#Set the IP address of the destination of index registration request
# base_uri = 'http://xxx.xxx.xxx.xxx:30013'
base_uri = 'http://' + fed + ':30013'

resource_path = '/sink_agent/api/put_idx'
header = { 'Content-type' => 'application/json' }
uri = base_uri + resource_path

#Set the data_id acquired in step 4
# data_id = "UUID"
data_id = "fa5c761b-e45c-4a00-b076-a7278c8463ec"

#[ucdavis@localhost scripts]$ ruby rawdata.rb
#code=200
#{"result":true,"data_id":"4332579a-1762-4af9-81a7-a762be3f0f4e"}
#[ucdavis@localhost scripts]$ date
#Thu Aug  2 16:58:19 PDT 2018

# [ucdavis@localhost scripts]$ ruby rawdata.rb
# code=200
# {"result":true,"data_id":"fa5c761b-e45c-4a00-b076-a7278c8463ec"}
# [ucdavis@localhost scripts]$ date
# Sun Aug  5 10:28:00 PDT 2018

#Create an index to be registered, make sure to include data_id in sink_info                                                                  
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

#Send index registration request
res = client.post(uri, payload.to_json, header)

#Get response (idx_id) at index registration
puts "code=#{res.code}"
puts res.body

#[ucdavis@localhost scripts]$ ruby put_idx.rb
#code=200
#{"result":true,"idx_id":"df9d0d84-9dce-4065-a5c6-0a79ca1ad3e7"}
#[ucdavis@localhost scripts]$ date
#Thu Aug  2 17:05:33 PDT 2018