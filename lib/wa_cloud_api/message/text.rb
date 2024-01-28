# frozen_string_literal: true

require_relative 'service'
require_relative 'base'

module WaCloudApi
  module Message
    class Text < Base
      attr_accessor :preview_url, :body

      def initialize(to:, body:, preview_url: false)
        @body = body
        @preview_url = preview_url || false
        super(to: to, type: 'text')
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
