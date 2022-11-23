module DragonHunt
  module Infrastructure
    class DbParty < ApplicationRecord
      def self.table_name
        'dragon_hunt_parties'
      end
    end
  end
end
