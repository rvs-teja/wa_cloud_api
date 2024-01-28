# frozen_string_literal: true

require 'json'

module WaCloudApi
  module Message
    class Response
      Contact = Struct.new(:input, :wa_id, keyword_init: true)
      Message = Struct.new(:id, keyword_init: true)

      attr_accessor :status, :data

      def initialize(status, response)
        @status = status.to_i
        @data = convert_keys_to_symbols(JSON.parse(response))
      end

      def ok?
        status == 200
      end

      def contacts
        data[:contacts]&.map(&Contact.method(:new)) || []
      end

      def messages
        data[:messages]&.map(&Message.method(:new)) || []
      end

      private

      def convert_keys_to_symbols(obj)
        case obj
        when Hash
          obj.transform_keys(&:to_sym)
             .transform_values { |value| convert_keys_to_symbols(value) }
        when Array
          obj.map { |item| convert_keys_to_symbols(item) }
        else
          obj
        end
      end
    end
  end
end
