class AddListIdToTodos < ActiveRecord::Migration
  def self.up
    add_column :todos, :list_id, :integer
  end

  def self.down
    remove_column :todos, :list_id
  end
end
