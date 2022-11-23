module CooperationNegotiation
  module Domain
    module Events
      class ContractDraftPrepared
        attr_accessor :client_id, :contract_id, :time
      end
    end
  end
end
