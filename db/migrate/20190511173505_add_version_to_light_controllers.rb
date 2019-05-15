class AddVersionToLightControllers < ActiveRecord::Migration[5.2]
  def change
  	add_column :light_controllers, :version, :float
  end
end
