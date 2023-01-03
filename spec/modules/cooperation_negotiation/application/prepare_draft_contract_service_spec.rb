require_relative "../../../rails_helper"

module CooperationNegotiation
  module Application
    describe PrepareDraftContractService do
      let(:client_id) { '00000000-0000-0000-0000-000000000001' }
      let(:repository) { Domain::ContractRepository.get }

      describe '.call' do
        it 'prepares a draft contract' do
          service = described_class.new
          service.call(client_id:)

          expect(repository.of_client_id(client_id)).to be_present
        end
      end
    end
  end
end
