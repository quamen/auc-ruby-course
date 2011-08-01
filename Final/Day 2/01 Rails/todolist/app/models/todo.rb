class Todo < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :list
  
  belongs_to :list
end
