require 'artoo'

connection :osc, adaptor: :osc, 
  port: '3333'
device :osc, driver: :osc

work do
  osc.add_method = '/test'
  on osc, :query_results => proc { |*value|
    message = value[1]
    puts "#{message.ip_address}:#{message.ip_port} -- #{message.address} -- #{message.to_a}"
  }
end
