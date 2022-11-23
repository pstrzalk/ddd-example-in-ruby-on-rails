module CooperationNegotiation
  module Infrastructure
    class DbContract < ApplicationRecord
      def self.table_name
        'cooperation_negotiation_contracts'
      end
    end
  end
end
