require_relative "../../../../rails_helper"

module CooperationNegotiation
  module Domain
    module Events
      describe ContractSigned do
        it 'has attributes' do
          event = described_class.new
          event.text = :foo
          event.contract_id = :boo
          event.client_id = :moo
          event.time = :zoo

          expect(event).to have_attributes(
            text: :foo,
            contract_id: :boo,
            client_id: :moo,
            time: :zoo
          )
        end
      end
    end
  end
end
