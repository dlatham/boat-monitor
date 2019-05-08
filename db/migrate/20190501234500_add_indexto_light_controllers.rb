class AddIndextoLightControllers < ActiveRecord::Migration[5.2]
  def change
  	add_index :light_controllers, [:name, :slug], unique: true
  end
end
