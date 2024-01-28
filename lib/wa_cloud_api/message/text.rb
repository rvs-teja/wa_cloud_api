# frozen_string_literal: true

require_relative 'service'

module WaCloudApi
  module Message
    class Text
      attr_accessor :messaging_product, :recipient_type, :to, :type, :preview_url, :body

      def initialize(to:, body:, preview_url: false)
        @messaging_product = 'whatsapp'
        @recipient_type = 'individual'
        @to = to
        @type = 'text'
        @body = body
        @preview_url = preview_url || false
      end

      def deliver
        Service.deliver(params: request_params)
      end

      private

      def request_params
        {
          messaging_product: messaging_product,
          recipient_type: recipient_type,
          to: to,
          type: type,
          text: {
            preview_url: preview_url,
            body: body
          }
        }
      end
    end
  end
end
