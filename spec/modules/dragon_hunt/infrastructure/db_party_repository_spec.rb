require_relative "../../../rails_helper"

module DragonHunt
  module Infrastructure
    describe DbPartyRepository do
      subject(:repository) { described_class.new }

      let(:id) { "00000000-0000-0000-0000-000000000001" }
      let(:client_id) { "00000000-0000-0000-0000-000000000002" }

      describe '#of_id' do
        it 'finds a persisted entry' do
          DbParty.create(id:, client_id:)

          party = repository.of_id(id)

          expect(party).to be_a(Domain::Party)
          expect(party).to have_attributes(id:, client_id:)
        end

        it 'does not find a persisted entry' do
          expect(repository.of_id(id)).to be_nil
        end
      end

      describe '#save' do
        it 'creates a new db_party record with given id' do
          party = Domain::Party.new(id:, client_id:)

          expect { repository.save(party) }.to change(DbParty, :count).by(1)

          db_party = DbParty.find(id)
          expect(db_party).to have_attributes(id:, client_id:)
        end

        it 'creates a new db_party record with generated id' do
          party = Domain::Party.new(client_id:)

          expect { repository.save(party) }.to change(DbParty, :count).by(1)

          db_party = DbParty.last
          expect(db_party.client_id).to eq client_id
          expect(db_party.id).not_to be_nil
        end

        it 'updates an existing db_party record' do
          db_party = DbParty.create(id:, client_id:)

          other_client_id = "00000000-0000-0000-0000-000000000003"
          party = Domain::Party.new(id:, client_id: other_client_id)

          expect { repository.save(party) }.not_to change(DbParty, :count)

          db_party.reload
          expect(db_party.client_id).to eq other_client_id
        end
      end
    end
  end
end
