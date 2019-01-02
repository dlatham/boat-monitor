class AddHmacToProbes < ActiveRecord::Migration[5.2]
  def change
    add_column :probes, :hmac, :boolean
  end
end
