# frozen_string_literal: true

require 'spec_helper'

describe WaCloudApi::Message::Reaction do
  let(:to) { '91999999999' }
  let(:message_id) { 'wa.id-123' }
  let(:emoji) { '\D83D\DE02' }
  let(:reaction) { described_class.new(to: to, message_id: message_id, emoji: emoji) }

  describe '#initialize' do
    it 'sets correct values' do
      expect(reaction.type).to eq('reaction')
      expect(reaction.to).to eq('91999999999')
      expect(reaction.message_id).to eq('wa.id-123')
      expect(reaction.emoji).to eq('\D83D\DE02')
    end
  end

  describe '.deliver' do
    let(:params) do
      {
        messaging_product: 'whatsapp',
        recipient_type: 'individual',
        to: '91999999999',
        type: 'reaction',
        reaction: {
          message_id: message_id,
          emoji: emoji
        }
      }
    end

    before do
      allow(WaCloudApi::Message::Service).to receive(:deliver).with(params: params)
    end

    it 'calls the service' do
      expect(WaCloudApi::Message::Service).to receive(:deliver).with(params: params).once
      reaction.deliver
    end
  end
end
