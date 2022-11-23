module DragonHunt
  module Infrastructure
    class DbPartyRepository
      def of_id(id)
        db_party = DbParty.find_by(id)
        return unless db_party

        Domain::Party.new(id: party.id, client_id: party.client_id)
      end

      def save(party)
        db_party = DbParty.find_by(id: party.id) if party.id
        db_party ||= DbParty.new

        db_party.assign_attributes(
          client_id: party.send(:client_id),
        )

        db_party.save!
      end
    end
  end
end
