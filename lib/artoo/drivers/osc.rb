require 'artoo/drivers/driver'

module Artoo
  module Drivers
    # The osc driver behaviors
    class Osc < Driver

      # Start driver and any required connections
      def start_driver
        begin
          every(interval) do
            handle_message_events
          end

          super
        rescue Exception => e
          Logger.error "Error starting Osc driver!"
          Logger.error e.message
          Logger.error e.backtrace.inspect
        end
      end
      
      def add_method= add_method
        @add_method = add_method
      end

      def handle_message_events
        connection.client.add_method @add_method do | message |
          publish(event_topic_name("query_results"), message)
        end
        connection.client.run
      end

    end
  end
end
