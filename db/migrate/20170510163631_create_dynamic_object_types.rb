class CreateDynamicObjectTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :dynamic_object_types do |t|
      t.string :name
      t.timestamps
    end
  end
end
