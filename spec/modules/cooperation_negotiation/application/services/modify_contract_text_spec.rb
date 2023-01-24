require_relative "../../../../rails_helper"

module CooperationNegotiation
  module Application
    module Services
      describe ModifyContractText do
        let(:client_id) { '00000000-0000-0000-0000-000000000001' }
        let(:repository) { Domain::ContractRepository.get }

        describe '.call' do
          it 'prepares a draft contract' do
            contract = Domain::Contract.prepare_draft(client_id:)
            repository.save(contract)

            contract_id = contract.id

            service = described_class.new
            service.call(contract_id:, text: 'Modified content')

            contract = repository.of_id(contract_id)

            expect(contract.text).to eq 'Modified content'
          end
        end
      end
    end
  end
end
