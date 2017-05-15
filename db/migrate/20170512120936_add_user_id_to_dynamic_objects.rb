class AddUserIdToDynamicObjects < ActiveRecord::Migration[5.0]
  def change
    add_column :dynamic_objects, :user_id, :integer
  end
end
