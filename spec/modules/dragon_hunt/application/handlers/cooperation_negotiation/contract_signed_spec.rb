require_relative "../../../../../rails_helper"

module DragonHunt
  module Application
    module Handlers
      module CooperationNegotiation
        describe ContractSigned do
          describe '.call' do
            it 'saves the party' do
              id = '001'
              client_id = '002'

              repository = instance_double(Infrastructure::DbPartyRepository, save: true)
              event = ::CooperationNegotiation::Domain::Events::ContractSigned.new
              event.client_id = client_id
              described_class.call(event, repository)

              expect(repository).to have_received(:save).with(Domain::Party.new(client_id:))
            end
          end
        end
      end
    end
  end
end
