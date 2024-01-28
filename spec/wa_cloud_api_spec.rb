# frozen_string_literal: true

require 'spec_helper'

describe WaCloudApi do
  describe '#configuration' do
    it 'yields a configuration object' do
      WaCloudApi.configure do |config|
        expect(config).to be_an_instance_of(WaCloudApi::Configuration)
      end
    end
  end

  describe '#configure' do
    before do
      WaCloudApi.configure do |config|
        config.phone_number_id = 'phone_number_id'
        config.token = 'wa-cloud-api-token'
      end
    end

    it 'sets configure options' do
      expect(WaCloudApi.configuration.phone_number_id).to eq('phone_number_id')
      expect(WaCloudApi.configuration.token).to eq('wa-cloud-api-token')
    end
  end
end
