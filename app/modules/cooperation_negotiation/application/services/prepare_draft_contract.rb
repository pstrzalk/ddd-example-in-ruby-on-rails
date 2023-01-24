module CooperationNegotiation
  module Application
    module Services
      class PrepareDraftContract
        def initialize
          self.repository = Domain::ContractRepository.get
        end

        def call(client_id:)
          contract = Domain::Contract.prepare_draft(client_id:)

          repository.save(contract)
        end

        private

        attr_accessor :repository
      end
    end
  end
end
