require 'artoo'
require 'lpd8806'

connection :osc, adaptor: :osc, 
  port: '3333'
device :osc, driver: :osc

  strip = Lpd8806.new("/dev/cu.usbserial-A700e0Gb")
  strip.set_packed_pixel("a",0x000)
work do
  osc.add_method = '/test'
  on osc, :query_results => proc { |*value|
    message = value[1]
    strip.set_packed_pixel("a",0x222)
    sleep(0.1)
    strip.set_packed_pixel("a",0x000)
  }
end