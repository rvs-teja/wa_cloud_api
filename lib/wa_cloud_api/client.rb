# frozen_string_literal: true

module WaCloudApi
  class Client
    def deliver(_params)
      validate_configuration
    end

    private

    def validate_configuration
      raise ArgumentError, 'Configuration is not set' if WaCloudApi.configuration.nil?

      WaCloudApi.configuration.valid?
    end
  end
end
