# frozen_string_literal: true

require 'spec_helper'

describe WaCloudApi::Message::Response do
  let(:status) { 200 }
  let(:body) { {} }
  let(:response) { described_class.new(status, body.to_json) }

  describe '.ok?' do
    context 'when status is 200' do
      it 'returns true' do
        expect(response).to be_ok
      end
    end

    context 'when status is not 200' do
      let(:status) { 404 }

      it 'returns false' do
        expect(response).not_to be_ok
      end
    end
  end

  describe '.contacts' do
    context 'when response has contacts' do
      let(:body) do
        {
          contacts: [
            {
              input: '9999999999',
              wa_id: '9999999999'
            }
          ]
        }
      end

      it 'returns array of contacts' do
        contacts = response.contacts

        expect(contacts).to be_a(Array)
        expect(contacts).not_to be_empty
        expect(contacts.first).to be_a(WaCloudApi::Message::Response::Contact)
      end
    end

    context 'when response does not have contacts' do
      it 'returns empty array' do
        contacts = response.contacts

        expect(contacts).to be_a(Array)
        expect(contacts).to be_empty
      end
    end
  end

  describe '.messages' do
    context 'when response has messages' do
      let(:body) do
        {
          messages: [
            {
              id: SecureRandom.uuid
            }
          ]
        }
      end

      it 'returns array of messages' do
        messages = response.messages

        expect(messages).to be_a(Array)
        expect(messages).not_to be_empty
        expect(messages.first).to be_a(WaCloudApi::Message::Response::Message)
      end
    end

    context 'when response does not have messages' do
      it 'returns empty array' do
        messages = response.messages

        expect(messages).to be_a(Array)
        expect(messages).to be_empty
      end
    end
  end
end
