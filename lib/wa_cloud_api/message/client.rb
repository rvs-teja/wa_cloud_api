# frozen_string_literal: true

require 'faraday'
require 'json'

require_relative 'response'
require_relative '../client'

module WaCloudApi
  module Message
    class Client < WaCloudApi::Client
      def self.deliver(params:)
        response = new.deliver(params)
        Response.new(response.status, response.body)
      end

      def deliver(params)
        super
        conn.post do |req|
          req.body = params.to_json
        end
      end

      private

      def url
        "https://graph.facebook.com/v18.0/#{WaCloudApi.configuration.phone_number_id}/messages"
      end

      def conn
        @conn ||= Faraday.new(url: url) do |faraday|
          faraday.adapter Faraday.default_adapter
          faraday.headers['Authorization'] = "Bearer #{WaCloudApi.configuration.token}"
          faraday.headers['Content-Type'] = 'application/json'
        end
      end
    end
  end
end
