class CreateTodos < ActiveRecord::Migration
  def self.up
    create_table :todos do |t|
      t.string :title
      t.text :note
      t.datetime :due_by
      t.boolean :completed

      t.timestamps
    end
  end

  def self.down
    drop_table :todos
  end
end
