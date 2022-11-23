module CooperationNegotiation
  module Application
    class PrepareDraftContractService
      def initialize
        self.repository = Infrastructure::DbContractRepository.new
      end

      def call(client_id:)
        contract = Domain::Contract.prepare_draft(client_id: client_id)

        repository.save(contract)
      end

      private

      attr_accessor :repository
    end
  end
end
