class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
    	t.integer		:user_id
    	t.integer		:dynamic_object_id
      t.timestamps
    end
  end
end
