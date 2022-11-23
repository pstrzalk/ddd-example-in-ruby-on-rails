class CreateDragonHuntParties < ActiveRecord::Migration[7.0]
  def change
    create_table :dragon_hunt_parties, id: :uuid do |t|
      t.uuid :client_id, index: { unique: true }

      t.timestamps
    end
  end
end
