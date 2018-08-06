require 'iotda_client_mqtt'
require 'optparse'
require 'json'
require 'yaml'

client = HTTPClient.new
config = YAML.load_file('config.yml')
fc = config['fc']
fc_port = config['fc_port']

client = IoTDAClient.new(host: fc, port: fc_port)

search_keyvalue = { :"location" => "loc-A", :"temp" => 25.5 }

queue_name = SecureRandom.uuid.to_s
client.subscribe_queue( queue_name: queue_name,
                        search_keyvalue: search_keyvalue )
sleep(5)


client.search_idx_v2( search_keyvalue: search_keyvalue,
    queue_name: queue_name )
sleep(5)