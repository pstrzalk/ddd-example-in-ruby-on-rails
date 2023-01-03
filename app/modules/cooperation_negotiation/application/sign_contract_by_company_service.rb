module CooperationNegotiation
  module Application
    class SignContractByCompanyService
      def initialize(repository: Infrastructure::DbContractRepository.new)
        self.repository = repository
      end

      def call(contract_id:)
        contract = repository.of_id(contract_id)
        contract.sign_by_company

        repository.save(contract)
      end

      private

      attr_accessor :repository
    end
  end
end
