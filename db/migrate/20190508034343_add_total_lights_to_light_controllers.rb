class AddTotalLightsToLightControllers < ActiveRecord::Migration[5.2]
  def change
  	add_column :light_controllers, :total_lights, :integer
  end
end
