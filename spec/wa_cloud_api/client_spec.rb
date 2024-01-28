# frozen_string_literal: true

require 'spec_helper'

describe WaCloudApi::Client do
  def reset_configuration
    WaCloudApi.configuration = nil
  end

  describe '.deliver' do
    let(:params) { { key: 'value' } }

    shared_examples 'raises argument error' do |arguments|
      it 'raises error' do
        expect do
          described_class.new.deliver(params)
        end.to raise_error(ArgumentError, "#{arguments.join(', ')} are not set in configuration")
      end
    end

    before do
      reset_configuration
    end

    context 'when the configuration is setup' do
      before do
        WaCloudApi.configure do |config|
          config.phone_number_id = 'phone-number-id'
          config.token = 'token'
        end
      end

      it 'does not raise error' do
        expect { described_class.new.deliver(params) }.not_to raise_error
      end
    end

    context 'when the configuration is not setup' do
      it 'raises argument error' do
        expect do
          described_class.new.deliver(params)
        end.to raise_error(ArgumentError, 'Configuration is not set')
      end
    end

    context 'when phone number is not configured' do
      before do
        WaCloudApi.configure do |config|
          config.token = 'token'
        end
      end

      include_examples 'raises argument error', ['phone_number_id']
    end

    context 'when token is not configured' do
      before do
        WaCloudApi.configure do |config|
          config.phone_number_id = 'phone-number-id'
        end
      end

      include_examples 'raises argument error', ['token']
    end

    context 'when no configuration params are not set' do
      before do
        WaCloudApi.configure {}
      end

      include_examples 'raises argument error', %w[phone_number_id token]
    end
  end
end
