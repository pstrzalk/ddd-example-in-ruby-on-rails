module CooperationNegotiation
  module Domain
    module Events
      class ContractSigned
        attr_accessor :contract_id, :client_id, :text, :time
      end
    end
  end
end
