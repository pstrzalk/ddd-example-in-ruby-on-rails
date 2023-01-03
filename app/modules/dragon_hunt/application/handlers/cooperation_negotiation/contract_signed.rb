module DragonHunt
  module Application
    module Handlers
      module CooperationNegotiation
        class ContractSigned
          def self.call(event)
            repository = Domain::PartyRepository.get
            party = Domain::Party.assemble(client_id: event.client_id)

            repository.save(party)
          end
        end
      end
    end
  end
end
