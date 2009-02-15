require 'test_helper'

class TodosControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index, :list_id => lists(:one)
    assert_response :success
    assert_not_nil assigns(:todos)
  end

  def test_should_get_new
    get :new, :list_id => lists(:one)
    assert_response :success
  end

  def test_should_create_todo
    assert_difference('Todo.count') do
      post :create, :list_id => lists(:one), :todo => { :title => "a todo entry" }
    end

    assert_redirected_to list_todo_path(lists(:one), assigns(:todo))
  end

  def test_should_show_todo
    get :show, :list_id => lists(:one), :id => todos(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :list_id => lists(:one), :id => todos(:one).id
    assert_response :success
  end

  def test_should_update_todo
    put :update, :list_id => lists(:one), :id => todos(:one).id, :todo => { }
    assert_redirected_to list_todo_path(lists(:one), assigns(:todo))
  end

  def test_should_destroy_todo
    assert_difference('Todo.count', -1) do
      delete :destroy, :list_id => lists(:one), :id => todos(:one).id
    end

    assert_redirected_to list_todos_path(lists(:one))
  end
end
