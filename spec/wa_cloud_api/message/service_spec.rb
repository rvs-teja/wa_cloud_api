# frozen_string_literal: true

require 'spec_helper'

describe WaCloudApi::Message::Service do
  let(:params) { { key: 'value' } }
  let(:client_response) { double(ok?: true) }

  describe '.deliver' do
    before do
      allow(WaCloudApi::Message::Client).to receive(:deliver).with(params: params).and_return(client_response)
    end

    context 'when delivery is successful' do
      it 'returns response' do
        expect(described_class.deliver(params: params)).to eq(client_response)
      end
    end

    context 'when delivery fails' do
      let(:response_body) do
        {
          error: {
            code: 123,
            message: 'error message'
          }
        }
      end
      let(:client_response) { double(ok?: false, data: response_body) }

      before do
        allow_any_instance_of(WaCloudApi::Message::Error).to receive(:handle_error)
      end

      it 'calls the error handler' do
        expect_any_instance_of(WaCloudApi::Message::Error).to receive(:handle_error)
        described_class.deliver(params: params)
      end
    end
  end
end
