module DragonHunt
  module Application
    module Handlers
      module CooperationNegotiation
        class ContractSigned
          def self.call(event)
            repository = Infrastructure::DbPartyRepository.new

            party = Domain::Party.assemble(client_id: event.client_id)
            repository.save(party)
          end
        end
      end
    end
  end
end
