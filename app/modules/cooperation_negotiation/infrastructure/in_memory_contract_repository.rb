module CooperationNegotiation
  module Infrastructure
    class InMemoryContractRepository
      attr_reader :event_store_write, :memory

      def initialize(event_store_write: ::EventStore::Write.new)
        @event_store_write = event_store_write
        @@memory ||= {}
      end

      def of_id(id)
        @@memory[id]
      end

      def of_client_id(client_id)
        @@memory.each do |id, contract|
          return contract if contract.client_id == client_id
        end

        nil
      end

      def save(contract)
        id = next_identity

        contract.send('id=', id)

        @@memory[id] = contract
        commit_events(contract)
      end

      private

      def next_identity
        SecureRandom.uuid
      end

      def commit_events(contract)
        return if contract.uncommited_events.blank?

        contract.uncommited_events.each do |event|
          event.contract_id = contract.id

          @event_store_write.call(event)
        end

        contract.clear_uncommited_events
      end
    end
  end
end
