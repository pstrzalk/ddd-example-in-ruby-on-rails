require_relative "../../../../../rails_helper"

module DragonHunt
  module Application
    module Handlers
      module CooperationNegotiation
        describe ContractSigned do
          describe '.call' do
            let(:id) { '00000000-0000-0000-0000-000000000001' }
            let(:client_id) { '00000000-0000-0000-0000-000000000002' }

            it 'saves the party' do
              event = ::CooperationNegotiation::Domain::Events::ContractSigned.new
              event.client_id = client_id
              described_class.call(event)

              repository = Domain::PartyRepository.get
              expect(repository.of_client_id(client_id)).to be_present
            end
          end
        end
      end
    end
  end
end
