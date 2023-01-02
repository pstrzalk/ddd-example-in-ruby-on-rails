require_relative "../../../rails_helper"

module CooperationNegotiation
  module Application
    describe PrepareDraftContractService do
      describe '.call' do
        it 'prepares a draft contract' do
          client_id = '00000000-0000-0000-0000-000000000001'
          repository = Infrastructure::InMemoryContractRepository.new

          service = described_class.new(repository: repository)
          service.call(client_id:)

          expect(repository.of_client_id(client_id)).to be_present
        end
      end
    end
  end
end
