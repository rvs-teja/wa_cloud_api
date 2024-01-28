require 'json'

require_relative 'base'

module WaCloudApi
  module Message
    class Reaction < Base
      attr_accessor :message_id, :emoji

      def initialize(to:, message_id:, emoji:)
        @message_id = message_id
        @emoji = JSON.parse("\"#{emoji}\"").encode('utf-8')
        super(to: to, type: 'reaction')
      end

      private

      def request_params
        {
          messaging_product: messaging_product,
          recipient_type: recipient_type,
          to: to,
          type: type,
          "reaction": {
            "message_id": message_id,
            "emoji": emoji
          }
        }
      end
    end
  end
end
