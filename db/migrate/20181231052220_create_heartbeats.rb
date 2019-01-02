class CreateHeartbeats < ActiveRecord::Migration[5.2]
  def change
    create_table :heartbeats do |t|
      t.references :probe, foreign_key: true
      t.float :voltage
      t.float :temp
      t.float :humid

      t.timestamps
    end
  end
end
