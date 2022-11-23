module CooperationNegotiation
  module Domain
    module Events
      class ContractTextModified
        attr_accessor :text, :contract_id, :time
      end
    end
  end
end
