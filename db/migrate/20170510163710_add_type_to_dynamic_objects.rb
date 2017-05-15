class AddTypeToDynamicObjects < ActiveRecord::Migration[5.0]
  def change
    add_column :dynamic_objects, :dynamic_object_type_id, :integer
    add_column :dynamic_objects, :properties, :text
  end
end
