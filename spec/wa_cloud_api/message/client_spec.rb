# frozen_string_literal: true

require 'spec_helper'

describe WaCloudApi::Message::Client do
  let(:params) { { key: 'value' } }
  let(:status) { 200 }
  let(:response_body) { {} }
  let(:phone_number_id) { 'phone-number-id' }
  let(:token) { 'wa-cloud-api-token' }

  before do
    stub_response
    reset_configuration

    WaCloudApi.configure do |config|
      config.phone_number_id = phone_number_id
      config.token = token
    end
  end

  describe '#deliver' do
    let(:response_body) do
      {
        success: true
      }
    end

    it 'returns the response' do
      response = described_class.deliver(params: params)
      expect(response).to be_ok
      expect(response).to be_a(WaCloudApi::Message::Response)
      expect(response.data).to eq(response_body)
    end
  end

  describe '.deliver' do
    it 'sends a post request with correct parameters' do
      described_class.new.deliver(params)

      expect(WebMock).to have_requested(:post, "https://graph.facebook.com/v18.0/#{phone_number_id}/messages")
        .with(
          body: params.to_json,
          headers: {
            'Authorization' => "Bearer #{token}",
            'Content-Type' => 'application/json'
          }
        )
    end
  end

  def stub_response
    stub_request(:post, "https://graph.facebook.com/v18.0/#{phone_number_id}/messages")
      .with(
        body: params.to_json,
        headers: {
          'Authorization' => "Bearer #{token}",
          'Content-Type' => 'application/json'
        }
      ).to_return(status: status, body: response_body.to_json, headers: {})
  end

  def reset_configuration
    WaCloudApi.configuration = nil
  end
end
