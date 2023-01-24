module CooperationNegotiation
  module Application
    module Services
      class SignContractByCompany
        def initialize
          self.repository = Domain::ContractRepository.get
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
end
