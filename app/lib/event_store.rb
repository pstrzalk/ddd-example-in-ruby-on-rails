module EventStore
  HANDLERS = {
    'CooperationNegotiation::Domain::Events::ContractSigned' => [
      'DragonHunt::Application::Handlers::CooperationNegotiation::ContractSigned',
      'ReadModelHandler'
    ]
  }.freeze

  class Write
    def call(event)
      handlers = HANDLERS[event.class.name]
      return unless handlers

      handlers.each do |handler_class_name|
        handler_class_name.constantize.call(event)
      end
    end
  end

  module Substitute
    class Write
      attr_reader :written

      def initialize
        @written = []
      end

      def call(event)
        handlers = HANDLERS[event.class.name]
        return unless handlers

        @written ||= []
        @written << event
      end
    end
  end
end
