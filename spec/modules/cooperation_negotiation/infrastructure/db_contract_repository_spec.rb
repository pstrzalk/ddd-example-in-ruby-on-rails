require_relative "../../../rails_helper"

module CooperationNegotiation
  module Infrastructure
    describe DbContractRepository do
      subject(:repository) { described_class.new(event_store_write: ::EventStore::Substitute::Write.new) }

      let(:id) { "00000000-0000-0000-0000-000000000001" }
      let(:client_id) { "00000000-0000-0000-0000-000000000002" }

      describe '#of_id' do
        it 'finds a persisted entry' do
          DbContract.create(
            id:,
            client_id:,
            text: 'foo',
            client_signature: true,
            company_signature: true
          )

          contract = repository.of_id(id)

          expect(contract).to be_a(Domain::Contract)
          expect(contract).to have_attributes(id:, client_id:)
          expect(contract.send(:client_signature)).to be true
          expect(contract.send(:company_signature)).to be true
        end

        it 'does not find a persisted entry' do
          expect(repository.of_id(id)).to be_nil
        end
      end

      describe '#of_client_id' do
        it 'finds a persisted entry' do
          DbContract.create(
            id:,
            client_id:,
            text: 'foo',
            client_signature: true,
            company_signature: true
          )

          contract = repository.of_client_id(client_id)

          expect(contract).to be_a(Domain::Contract)
          expect(contract).to have_attributes(id:, client_id:)
          expect(contract.send(:client_signature)).to be true
          expect(contract.send(:company_signature)).to be true
        end

        it 'does not find a persisted entry' do
          expect(repository.of_id(client_id)).to be_nil
        end
      end

      describe '#save' do
        it 'creates a new db_contract record with given id' do
          contract = Domain::Contract.new(id:, client_id:)
          contract.modify_text('bar')
          contract.sign_by_client
          contract.sign_by_company

          expect { repository.save(contract) }.to change(DbContract, :count).by(1)

          db_contract = DbContract.find(id)
          expect(db_contract).to have_attributes(
            id:,
            client_id:,
            text: 'bar',
            client_signature: true,
            company_signature: true
          )
        end

        it 'commits ContractSigned event' do
          time = '2023-01-01 23:18:44 UTC'
          ::Clock.utc = time

          contract = Domain::Contract.prepare_draft(client_id:)
          contract.modify_text('foo')
          contract.sign_by_client
          contract.sign_by_company

          contract_signed = contract.uncommited_events.find { |event| event.is_a?(Domain::Events::ContractSigned) }
          repository.save(contract)
          expect(contract.uncommited_events.size).to eq 0

          written_events = repository.event_store_write.written
          expect(written_events.size).to eq 1
          expect(written_events.first).to be_a(Domain::Events::ContractSigned)
          expect(written_events.first).to have_attributes(client_id:, time:, text: 'foo')
        end

        it 'creates a new db_contract record with generated id' do
          contract = Domain::Contract.new(client_id:)

          expect { repository.save(contract) }.to change(DbContract, :count).by(1)

          db_contract = DbContract.last
          expect(db_contract.client_id).to eq client_id
          expect(db_contract.id).not_to be_nil

          expect(contract.id).to eq db_contract.id
        end

        it 'updates an existing db_contract record' do
          db_contract = DbContract.create(id:, client_id:)

          other_client_id = "00000000-0000-0000-0000-000000000003"
          contract = Domain::Contract.new(id:, client_id: other_client_id)

          expect { repository.save(contract) }.not_to change(DbContract, :count)

          db_contract.reload
          expect(db_contract.client_id).to eq other_client_id
        end
      end
    end
  end
end
