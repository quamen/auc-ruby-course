class List < ActiveRecord::Base
  validates_presence_of :title
  validates_uniqueness_of :title
  
  has_many :todos, :class_name => "Todo", :foreign_key => "list_id"
end
