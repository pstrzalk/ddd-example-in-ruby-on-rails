module CooperationNegotiation
  module Application
    class SignContractByClientService
      def initialize
        self.repository = Domain::ContractRepository.get
      end

      def call(contract_id:)
        contract = repository.of_id(contract_id)
        contract.sign_by_client

        repository.save(contract)
      end

      private

      attr_accessor :repository
    end
  end
end
