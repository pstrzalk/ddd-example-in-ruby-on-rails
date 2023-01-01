module DragonHunt
  module Domain
    class Party
      attr_reader :id, :client_id

      def self.assemble(client_id:)
        new(client_id: client_id)
      end

      def initialize(client_id:, id: nil)
        self.id = id
        self.client_id = client_id
      end

      def ==(other)
        id == other.id && client_id == other.client_id
      end

      private

      attr_writer :id, :client_id
    end
  end
end
