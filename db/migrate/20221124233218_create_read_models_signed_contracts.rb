class CreateReadModelsSignedContracts < ActiveRecord::Migration[7.0]
  def change
    create_table :read_models_signed_contracts, id: :uuid do |t|
      t.uuid :client_id
      t.text :text

      t.timestamps
    end
  end
end
