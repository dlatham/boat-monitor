class CreateProbes < ActiveRecord::Migration[5.2]
  def change
    create_table :probes do |t|
      t.string :name
      t.string :secret

      t.timestamps
    end
  end
end
