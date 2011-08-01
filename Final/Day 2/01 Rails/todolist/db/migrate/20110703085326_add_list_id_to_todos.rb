class AddListIdToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :list_id, :integer
    add_index :todos, :list_id
  end
end