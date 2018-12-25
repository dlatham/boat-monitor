class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :phone
      t.string :name
      t.boolean :bilge_main
      t.boolean :bilge_backup
      t.boolean :charge_error

      t.timestamps
    end
  end
end
