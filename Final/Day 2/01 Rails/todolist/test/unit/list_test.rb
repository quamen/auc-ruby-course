require 'test_helper'

class ListTest < ActiveSupport::TestCase
  
  def setup
    @list = lists(:one)
  end
    
  should validate_presence_of(:title)
  should validate_uniqueness_of(:title)
  
  should have_many(:todos)
  
end