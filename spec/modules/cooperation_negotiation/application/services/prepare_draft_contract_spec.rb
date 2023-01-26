require_relative "../../../../rails_helper"

module CooperationNegotiation
  module Application
    module Services
      describe PrepareDraftContract do
        let(:identity) { '00000000-0000-0000-0000-000000000000' }
        let(:client_id) { '00000000-1234-1234-1234-000000000000' }
        let(:repository) { Domain::ContractRepository.get }

        describe '.call' do
          it 'prepares a draft contract' do
            allow(Authorization::Application::Api)
              .to receive(:identity_in_role?).with(identity, 'admin').and_return(true)

            service = described_class.new
            service.call(identity:, client_id:)

            expect(repository.of_client_id(client_id)).to be_present
          end

          it 'raises unauthorized' do
            allow(Authorization::Application::Api)
              .to receive(:identity_in_role?).with(identity, 'admin').and_return(false)

            service = described_class.new

            expect { service.call(identity:, client_id:) }.to raise_error(PrepareDraftContract::Unauthorized)
          end
        end
      end
    end
  end
end
