# frozen_string_literal: true

module WaCloudApi
  module Message
    Error = Struct.new(:message, :type, :code, :fbtrace_id, :error_subcode, keyword_init: true) do
      def handle_error
        raise WaCloudApi::Error, message
      end
    end
  end
end
