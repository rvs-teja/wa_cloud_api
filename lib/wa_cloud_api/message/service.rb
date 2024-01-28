# frozen_string_literal: true

require_relative 'client'
require_relative 'error'

module WaCloudApi
  module Message
    class Service
      class << self
        def deliver(params:)
          response = Client.deliver(params: params)
          handle_failure(response) unless response.ok?
          response
        end

        private

        def handle_failure(response)
          WaCloudApi::Message::Error.new(response.data[:error]).handle_error
        end
      end
    end
  end
end
