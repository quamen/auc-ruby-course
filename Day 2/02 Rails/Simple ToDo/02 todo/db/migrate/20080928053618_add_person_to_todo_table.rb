class AddPersonToTodoTable < ActiveRecord::Migration
  def self.up
    add_column :todos, :person_id, :string
  end

  def self.down
    remove_column :todos, :person_id
  end
end
