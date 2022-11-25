module ReadModels
  class SignedContract < ApplicationRecord
    def self.table_name
      'read_models_signed_contracts'
    end

    def self.save_record(contract_id, attributes = {})
      attributes_with_unique_identity = attributes.merge(id: contract_id)

      upsert(
        attributes_with_unique_identity,
        unique_by: :id
      )
    end
  end
end
