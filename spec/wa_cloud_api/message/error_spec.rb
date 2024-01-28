# frozen_string_literal: true

require 'spec_helper'

describe WaCloudApi::Message::Error do

  let(:params) { {} }
  let(:error) { WaCloudApi::Message::Error.new(params) }

  describe '.handle_error' do

    context 'when error_data is present' do
      let(:params) do
        {
          message: 'error message',
          error_data: {
            details: 'details error message'
          }
        }
      end

      it 'raises error with details' do
        expect do
          error.handle_error
        end.to raise_error(WaCloudApi::Error, 'details error message')
      end
    end

    context 'when error data is not present' do
      let(:params) do
        {
          message: 'error message'
        }
      end

      it 'raises error with details' do
        expect do
          error.handle_error
        end.to raise_error(WaCloudApi::Error, 'error message')
      end
    end
  end
end
