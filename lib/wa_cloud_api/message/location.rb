require_relative 'base'

module WaCloudApi
  module Message
    class Location < Base
      attr_accessor :longitude, :latitude, :name, :address

      def initialize(to:, longitude:, latitude:, name: nil, address: nil)
        @longitude = longitude
        @latitude = latitude
        @name = name
        @address = address
        super(to: to, type: 'location')
      end

      private

      def request_params
        {
          messaging_product: messaging_product,
          to: to,
          type: type,
          location: {
            longitude: longitude,
            latitude: latitude,
            name: name,
            address: address
          }
        }
      end
    end
  end
end
