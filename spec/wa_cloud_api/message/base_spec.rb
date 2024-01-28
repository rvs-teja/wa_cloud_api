require 'spec_helper'

describe WaCloudApi::Message::Base do
  let(:to) { '91999999999' }
  let(:type) { 'type' }

  let(:message) { described_class.new(to: to, type: type) }

  describe '#initialize' do
    it 'sets default values' do
      expect(message.messaging_product).to eq('whatsapp')
      expect(message.recipient_type).to eq('individual')
      expect(message.to).to eq('91999999999')
      expect(message.type).to eq('type')
    end
  end

  describe '.deliver' do

    before do
      allow(WaCloudApi::Message::Service).to receive(:deliver)
      allow(message).to receive(:request_params).and_return({ to: to, type: type })
    end

    it 'calls the service' do
      expect(WaCloudApi::Message::Service).to receive(:deliver).with(params: { to: to, type: type }).once

      message.deliver
    end
  end
end
