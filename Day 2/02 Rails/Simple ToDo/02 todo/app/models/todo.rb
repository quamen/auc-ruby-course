class Todo < ActiveRecord::Base
  validates_presence_of :title, :list_id

  belongs_to :list, :class_name => "List", :foreign_key => "list_id"
  
  belongs_to :person, :class_name => "Person", :foreign_key => "person_id"
end
