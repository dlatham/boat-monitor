class AddUsernamePasswordtoLightControllers < ActiveRecord::Migration[5.2]
  def change
  	add_column :light_controllers, :username, :string
  	add_column :light_controllers, :password, :string
  end
end
