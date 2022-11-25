module Infrastructure
  module EventStore
    HANDLERS = {
      'CooperationNegotiation::Domain::Events::ContractSigned' => [
        'DragonHunt::Application::Handlers::CooperationNegotiation::ContractSigned',
        'ReadModelHandler'
      ]
    }.freeze

    Write = Class.new do
      def self.call(event)
        handlers = HANDLERS[event.class.name]
        return unless handlers

        handlers.each do |handler_class_name|
          handler_class_name.constantize.call(event)
        end
      end
    end
  end
end
