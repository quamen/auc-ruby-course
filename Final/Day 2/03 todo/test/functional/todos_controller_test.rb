require 'test_helper'

class TodosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:todos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create todo" do
    assert_difference('Todo.count') do
      post :create, :todo => { :title => "My Todo"}
    end

    assert_redirected_to todo_path(assigns(:todo))
  end

  test "should show todo" do
    get :show, :id => todos(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => todos(:one).id
    assert_response :success
  end

  test "should update todo" do
    put :update, :id => todos(:one).id, :todo => { }
    assert_redirected_to todo_path(assigns(:todo))
  end

  test "should destroy todo" do
    assert_difference('Todo.count', -1) do
      delete :destroy, :id => todos(:one).id
    end

    assert_redirected_to todos_path
  end
end