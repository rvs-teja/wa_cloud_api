# frozen_string_literal: true

module WaCloudApi
  class Configuration
    attr_accessor :phone_number_id, :token

    MANDATORY_ATTRIBUTES = %i[phone_number_id token].freeze

    def initialize
      @missing_params = []
    end

    def valid?
      MANDATORY_ATTRIBUTES.each do |attribute|
        @missing_params << attribute unless instance_variable_defined?("@#{attribute}")
      end

      raise ArgumentError, "#{@missing_params.join(', ')} are not set in configuration" unless @missing_params.empty?

      true
    end
  end
end
