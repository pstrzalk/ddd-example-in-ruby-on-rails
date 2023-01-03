module DragonHunt
  module Infrastructure
    class DbPartyRepository
      def of_id(id)
        db_party = DbParty.find_by(id:)
        return unless db_party

        Domain::Party.new(id: id, client_id: db_party.client_id)
      end

      def of_client_id(client_id)
        db_party = DbParty.find_by(client_id: client_id)
        return unless db_party

        Domain::Party.new(id: db_party.id, client_id: db_party.client_id)
      end

      def save(party)
        db_party = DbParty.find_by(id: party.id) if party.id
        db_party ||= DbParty.new(id: party.id)

        db_party.assign_attributes(
          client_id: party.send(:client_id),
        )

        db_party.save!
      end
    end
  end
end
