class CreateBilges < ActiveRecord::Migration[5.2]
  def change
    create_table :bilges do |t|
      t.integer :pump_no
      t.float :duration

      t.timestamps
    end
  end
end
