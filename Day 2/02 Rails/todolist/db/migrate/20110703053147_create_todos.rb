class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :title
      t.text :note
      t.datetime :due_by
      t.boolean :complete

      t.timestamps
    end
  end
end
