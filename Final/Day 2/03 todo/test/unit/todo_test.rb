require 'test_helper'

class TodoTest < ActiveSupport::TestCase
  
  def test_fixture_todos_should_belong_to_the_same_list
    assert_equal todos(:one).list, todos(:two).list
  end
  
  def test_fixture_todo_should_be_able_to_access_list_title
    assert_equal todos(:one).list.title, "MyString"
  end
  
  def test_invalid_with_emtpy_attributes
    todo = Todo.new
    assert !todo.valid?
    
    assert todo.errors.invalid?(:title)
    # assert todo.errors.invalid?(:list_id)
    
    assert_equal ActiveRecord::Errors.default_error_messages[:blank], todo.errors.on(:title)
    # assert_equal ActiveRecord::Errors.default_error_messages[:blank], todo.errors.on(:list_id)
  end
  
end
