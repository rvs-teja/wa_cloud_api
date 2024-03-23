# frozen_string_literal: true

require_relative 'wa_cloud_api/version'
require_relative 'wa_cloud_api/message/text'
require_relative 'wa_cloud_api/message/reaction'
require_relative 'wa_cloud_api/message/location'
require_relative 'wa_cloud_api/configuration'

module WaCloudApi
  class Error < StandardError; end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
