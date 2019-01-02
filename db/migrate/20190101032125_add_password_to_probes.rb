class AddPasswordToProbes < ActiveRecord::Migration[5.2]
  def change
    add_column :probes, :password, :string
  end
end
