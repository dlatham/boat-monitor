class CreateLightControllers < ActiveRecord::Migration[5.2]
  def change
    create_table :light_controllers do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.string :local_base_url
      t.string :remote_base_url
      t.jsonb :power_config
      t.jsonb :switch_config
      t.jsonb :status

      t.timestamps
    end
  end
end
