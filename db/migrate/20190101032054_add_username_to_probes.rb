class AddUsernameToProbes < ActiveRecord::Migration[5.2]
  def change
    add_column :probes, :username, :string
  end
end
