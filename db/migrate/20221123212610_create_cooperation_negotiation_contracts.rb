class CreateCooperationNegotiationContracts < ActiveRecord::Migration[7.0]
  def change
    create_table :cooperation_negotiation_contracts, id: :uuid do |t|
      t.uuid :client_id, index: { unique: true }
      t.boolean :client_signature, default: false
      t.boolean :company_signature, default: false

      t.text :text, default: ''

      t.timestamps
    end
  end
end
