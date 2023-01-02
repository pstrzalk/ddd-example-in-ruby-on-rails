require_relative "../../../../rails_helper"

module CooperationNegotiation
  module Domain
    module Events
      describe ContractDraftPrepared do
        it 'has attributes' do
          event = described_class.new
          event.contract_id = :boo
          event.client_id = :moo
          event.time = :zoo

          expect(event).to have_attributes(
            contract_id: :boo,
            client_id: :moo,
            time: :zoo
          )
        end
      end
    end
  end
end
