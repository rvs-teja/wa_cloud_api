# frozen_string_literal: true

module WaCloudApi
  module Message
    Error = Struct.new(:message, :type, :code, :fbtrace_id, :error_subcode, :error_data, keyword_init: true) do

      def handle_error
        raise WaCloudApi::Error, error_message
      end

      private

      def error_message
        error_data&.dig(:details) || message
      end
    end
  end
end
