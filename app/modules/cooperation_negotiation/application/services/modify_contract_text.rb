module CooperationNegotiation
  module Application
    module Services
      class ModifyContractText
        def initialize
          self.repository = Domain::ContractRepository.get
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
end
