class CreateDynamicObjectFields < ActiveRecord::Migration[5.0]
  def change
    create_table :dynamic_object_fields do |t|
      t.string :name
      t.string :field_type
      t.boolean :required
      t.belongs_to :dynamic_object_type
      t.timestamps
    end
  end
end
