require 'artoo/adaptors/adaptor'

module Artoo
  module Adaptors
    # Connect to a osc device
    # @see device documentation for more information
    class Osc < Adaptor
      attr_reader :device, :client

      # Creates a connection with device
      # @return [Boolean]
      def connect
        require 'osc-ruby' unless defined?(::OSC)
        port = additional_params[:port] || 3333
        @client = OSC::Server.new(port)
        super
      end

      # Closes connection with device
      # @return [Boolean]
      def disconnect
        super
      end

      # Name of device
      # @return [String]
      def name
        "osc"
      end

      # Version of device
      # @return [String]
      def version
        Artoo::Osc::VERSION
      end

      # Uses method missing to call device actions
      # @see device documentation
      def method_missing(method_name, *arguments, &block)
        device.send(method_name, *arguments, &block)
      end
    end
  end
end
