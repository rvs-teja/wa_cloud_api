# frozen_string_literal: true

require 'spec_helper'

describe WaCloudApi::Configuration do
  let(:phone_number_id) { 'phone-number-id' }
  let(:token) { 'token' }

  describe '.valid?' do
    context 'when all mandatory attributes are set' do
      it 'returns true' do
        config = described_class.new
        config.phone_number_id = phone_number_id
        config.token = token

        expect(config).to be_valid
      end
    end

    context 'when phone number id is not set' do
      it 'raises argument error' do
        config = described_class.new
        config.token = token

        expect do
          config.valid?
        end.to raise_error(ArgumentError, 'phone_number_id are not set in configuration')
      end
    end

    context 'when token is not set' do
      it 'raises argument error' do
        config = described_class.new
        config.phone_number_id = phone_number_id

        expect do
          config.valid?
        end.to raise_error(ArgumentError, 'token are not set in configuration')
      end
    end

    context 'when some mandatory attributes are not set' do
      it 'raises argument error' do
        config = described_class.new

        expect do
          config.valid?
        end.to raise_error(ArgumentError, 'phone_number_id, token are not set in configuration')
      end
    end
  end
end
