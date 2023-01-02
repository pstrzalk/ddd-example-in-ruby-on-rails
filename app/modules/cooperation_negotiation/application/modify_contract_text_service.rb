module CooperationNegotiation
  module Application
    class ModifyContractTextService
      def initialize(repository: Infrastructure::DbContractRepository.new)
        self.repository = repository
      end

      def call(contract_id:, text:)
        contract = repository.of_id(contract_id)
        contract.modify_text(text)

        repository.save(contract)
      end

      private

      attr_accessor :repository
    end
  end
end
