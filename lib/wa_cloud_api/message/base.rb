module WaCloudApi
  module Message
    class Base
      attr_accessor :messaging_product, :recipient_type, :to, :type

      def initialize(to:, type:)
        @messaging_product = 'whatsapp'
        @recipient_type = 'individual'
        @to = to
        @type = type
      end

      def deliver
        Service.deliver(params: request_params)
      end

      private

      def request_params
        raise NotImplementedError, 'Should be implemented by child class'
      end
    end
  end
end
