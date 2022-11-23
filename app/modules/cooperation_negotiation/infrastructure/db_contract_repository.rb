module CooperationNegotiation
  module Infrastructure
    class DbContractRepository
      def of_id(id)
        db_contract = DbContract.find_by(id: id)
        return unless db_contract

        build_from_db_contract(db_contract)
      end

      def of_client_id(client_id)
        db_contract = DbContract.find_by(client_id: client_id)
        return unless db_contract

        build_from_db_contract(db_contract)
      end

      def save(contract)
        db_contract = DbContract.find_by(id: contract.id) if contract.id
        db_contract ||= DbContract.new

        db_contract.assign_attributes(
          client_id: contract.send(:client_id),
          text: contract.send(:text),
          client_signature: contract.send(:client_signature),
          company_signature: contract.send(:company_signature)
        )

        ActiveRecord::Base.transaction do
          db_contract.save!

          contract.send('id=', db_contract.id)
          commit_events(contract)
        end
      end

      private

      def build_from_db_contract(db_contract)
        contract = Domain::Contract.new(id: db_contract.id, client_id: db_contract.client_id)
        contract.send('text=', db_contract.text)
        contract.send('client_signature=', db_contract.client_signature)
        contract.send('company_signature=', db_contract.company_signature)

        contract
      end

      def commit_events(contract)
        return if contract.uncommited_events.blank?

        contract.uncommited_events.each do |event|
          event.contract_id = contract.id

          ::Infrastructure::EventStore::Write.call(event)
        end

        contract.clear_uncommited_events
      end
    end
  end
end
