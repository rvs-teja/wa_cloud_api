require 'spec_helper'

describe WaCloudApi::Message::Location do
  let(:latitude) { 12.3456 }
  let(:longitude) { 98.7654 }
  let(:to) { '91999999999' }
  let(:name) { 'Location Name' }
  let(:address) { '123, Street, City, Country' }

  let(:location) do
    described_class.new(
      to: to,
      latitude: latitude,
      longitude: longitude,
      name: name,
      address: address
    )
  end

  describe '#initialize' do
    it 'sets correct values' do
      expect(location.type).to eq('location')
      expect(location.to).to eq('91999999999')
      expect(location.latitude).to eq(12.3456)
      expect(location.longitude).to eq(98.7654)
      expect(location.name).to eq('Location Name')
      expect(location.address).to eq('123, Street, City, Country')
    end
  end

  describe '.deliver' do
    let(:params) do
      {
        messaging_product: 'whatsapp',
        to: to,
        type: 'location',
        location: {
          longitude: longitude,
          latitude: latitude,
          name: name,
          address: address
        }
      }
    end

    before do
      allow(WaCloudApi::Message::Service).to receive(:deliver).with(params: params)
    end

    it 'calls the service' do
      expect(WaCloudApi::Message::Service).to receive(:deliver).with(params: params).once

      location.deliver
    end

  end
end
