require_relative "../../../rails_helper"

module DragonHunt
  module Domain
    describe Party do
      let(:id) { SecureRandom.uuid }
      let(:client_id) { SecureRandom.uuid }

      describe '.assemble' do
        let(:assembled_party) { described_class.assemble(client_id: client_id) }

        it { expect(assembled_party).to be_a(Party) }
        it { expect(assembled_party.client_id).to eq client_id }
      end

      describe '.initialize' do
        it 'initializes' do
          party = described_class.new(client_id: , id:)

          expect(party.client_id).to eq client_id
          expect(party.id).to eq id
        end

        context 'when id is not provided' do
          it 'initializes' do
            party = described_class.new(client_id:)

            expect(party.client_id).to eq client_id
            expect(party.id).to eq nil
          end
        end
      end
    end
  end
end
