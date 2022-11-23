module CooperationNegotiation
  module Domain
    module Events
      class ContractSigned
        attr_accessor :contract_id, :client_id, :time
      end
    end
  end
end
