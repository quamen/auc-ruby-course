class Todo < ActiveRecord::Base
  validates_presence_of :title, :list_id

  belongs_to :list, :class_name => "List", :foreign_key => "list_id"
end
