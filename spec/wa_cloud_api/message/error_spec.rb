# frozen_string_literal: true

require 'spec_helper'

describe WaCloudApi::Message::Error do
  let(:params) do
    {
      message: 'error message',
      type: 'OAuthException',
      code: 190,
      fbtrace_id: 'fb-trace-id'
    }
  end

  let(:error) { WaCloudApi::Message::Error.new(params) }

  describe '.handle_error' do
    it 'raises standard error' do
      expect do
        error.handle_error
      end.to raise_error(WaCloudApi::Error, 'error message')
    end
  end
end
