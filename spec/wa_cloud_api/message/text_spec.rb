# frozen_string_literal: true

require 'spec_helper'

describe WaCloudApi::Message::Text do
  let(:to) { '91999999999' }
  let(:body) { 'Hello World!!!' }
  let(:text_message) { described_class.new(to: to, body: body) }

  describe '#initialize' do
    it 'sets correct values' do
      expect(text_message.type).to eq('text')
      expect(text_message.to).to eq('91999999999')
      expect(text_message.body).to eq('Hello World!!!')
      expect(text_message.preview_url).to be_falsey
    end

    it 'overrides preview url when provided' do
      text_message = described_class.new(to: to, body: body, preview_url: true)

      expect(text_message.preview_url).to be_truthy
    end
  end

  describe '.deliver' do
    let(:params) do
      {
        messaging_product: 'whatsapp',
        recipient_type: 'individual',
        to: '91999999999',
        type: 'text',
        text: {
          preview_url: false,
          body: 'Hello World!!!'
        }
      }
    end

    before do
      allow(WaCloudApi::Message::Service).to receive(:deliver).with(params: params).once
    end

    it 'calls the service' do
      expect(WaCloudApi::Message::Service).to receive(:deliver).with(params: params)
      text_message.deliver
    end
  end
end
