require 'test_helper'

class ListTest < ActiveSupport::TestCase
  def test_invalid_with_emtpy_attributes
    list = List.new
    assert !list.valid?
    assert list.errors.invalid?(:title)
  end
  
  def test_title_is_unique
    list1 = List.create(:title => "something")
    list2 = List.new(:title => "something")
    
    assert !list2.save
    assert list2.errors.invalid?(:title)
    assert_equal ActiveRecord::Errors.default_error_messages[:taken], list2.errors.on(:title)
  end
  
  def test_fixture_list_one_should_contain_two_todos
    assert_equal lists(:one).todos.length, 2
  end
  
  def test_fixture_list_two_should_contain_zero_todos
    assert_equal lists(:two).todos.length, 0
  end
end
