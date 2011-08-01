require 'test_helper'

class TodoTest < ActiveSupport::TestCase
  
  should validate_presence_of(:title)
  should validate_presence_of(:list)
  
  should belong_to(:list)
  
end