require_relative "../../../rails_helper"

module CooperationNegotiation
  module Domain
    describe Contract do
      let(:id) { SecureRandom.uuid }
      let(:client_id) { SecureRandom.uuid }

      describe '.prepare_draft' do
        it 'initializes a contract with an event' do
          time = '2023-01-01 23:18:44 UTC'
          ::Clock.utc = time

          contract = described_class.prepare_draft(client_id:)

          expect(contract).to be_a(Contract)
          expect(contract.client_id).to eq client_id

          events = contract.uncommited_events
          expect(events.size).to eq 1
          event = events.first
          expect(event).to be_a(Events::ContractDraftPrepared)
          expect(event).to have_attributes(client_id:, time:)
        end
      end

      describe '.initialize' do
        it 'initializes a new contract' do
          contract = described_class.new(client_id:)

          expect(contract).to have_attributes(id: nil, client_id:)
          expect(contract.send(:text)).to eq ''
          expect(contract.send(:client_signature)).to be false
          expect(contract.send(:company_signature)).to be false
        end
      end

      describe '.sign_by_client' do
        it 'marks as signed by client' do
          contract = described_class.new(client_id:)

          contract.sign_by_client

          expect(contract).to be_signed_by_client
          expect(contract.uncommited_events).to be_empty
        end

        context 'already signed by client' do
          it 'raises error' do
            contract = described_class.new(client_id:)
            contract.sign_by_client

            expect { contract.sign_by_client }.to raise_error(Contract::AlreadySignedByClientError)
          end
        end

        context 'signed by company before' do
          it 'dispaches an event' do
            time = '2023-01-01 23:18:44 UTC'
            ::Clock.utc = time

            contract = described_class.new(client_id:)
            contract.send('text=', 'bar')
            contract.sign_by_company
            contract.sign_by_client

            expect(contract).to be_signed_by_client

            events = contract.uncommited_events
            expect(events.size).to eq 1
            event = events.first
            expect(event).to be_a(Events::ContractSigned)
            expect(event).to have_attributes(time:, client_id:, text: 'bar')
          end
        end
      end

      describe 'signed_by_client?' do
        it 'is true' do
          contract = described_class.new(client_id:)
          contract.sign_by_client
          expect(contract).to be_signed_by_client
        end

        it 'is false' do
          contract = described_class.new(client_id:)
          expect(contract).not_to be_signed_by_client
        end
      end

      describe '.sign_by_company' do
        it 'marks as signed by company' do
          contract = described_class.new(client_id:)
          contract.sign_by_company

          expect(contract).to be_signed_by_company
          expect(contract.uncommited_events).to be_empty
        end

        context 'already signed by company' do
          it 'raises error' do
            contract = described_class.new(client_id:)
            contract.sign_by_company

            expect { contract.sign_by_company }.to raise_error(Contract::AlreadySignedByCompanyError)
          end
        end

        context 'signed by client before' do
          it 'dispaches an event' do
            time = '2023-01-01 23:18:44 UTC'
            ::Clock.utc = time

            contract = described_class.new(client_id:)
            contract.send('text=', 'bar')
            contract.sign_by_client
            contract.sign_by_company

            expect(contract).to be_signed_by_company

            events = contract.uncommited_events
            expect(events.size).to eq 1
            event = events.first
            expect(event).to be_a(Events::ContractSigned)
            expect(event).to have_attributes(time:, client_id:, text: 'bar')
          end
        end
      end

      describe 'signed_by_company?' do
        it 'is true' do
          contract = described_class.new(client_id:)
          contract.sign_by_company
          expect(contract).to be_signed_by_company
        end

        it 'is false' do
          contract = described_class.new(client_id:)
          expect(contract).not_to be_signed_by_company
        end
      end

      describe '.modify_text' do
        it 'changes the text' do
          time = '2023-01-01 23:18:44 UTC'
          ::Clock.utc = time

          contract = described_class.new(client_id:)
          contract.modify_text('foo')

          expect(contract.send(:text)).to eq 'foo'

          events = contract.uncommited_events
          expect(events.size).to eq 1
          event = events.first
          expect(event).to be_a(Events::ContractTextModified)
          expect(event).to have_attributes(time:, text: 'foo')
        end

        it 'clears client signature' do
          contract = described_class.new(client_id:)
          contract.sign_by_client
          contract.modify_text('foo')

          expect(contract).not_to be_signed_by_client
        end

        it 'clears company signature' do
          contract = described_class.new(client_id:)
          contract.sign_by_company
          contract.modify_text('foo')

          expect(contract).not_to be_signed_by_company
        end

        it 'raises error' do
          contract = described_class.new(client_id:)
          contract.sign_by_client
          contract.sign_by_company

          expect { contract.modify_text('foo') }.to raise_error(Contract::AlreadySignedError)
        end
      end
    end
  end
end
