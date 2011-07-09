require 'test_helper'

class TodosControllerTest < ActionController::TestCase
  setup do
    @todo = todos(:one)
  end

  test "should get index" do
    get :index, list_id: lists(:one)
    assert_response :success
    assert_not_nil assigns(:todos)
  end

  test "should get new" do
    get :new, list_id: lists(:one)
    assert_response :success
  end

  test "should create todo" do
    assert_difference('Todo.count') do
      post :create, list_id: lists(:one), todo: @todo.attributes
    end

    assert_redirected_to list_todo_path(lists(:one), assigns(:todo))
  end

  test "should show todo" do
    get :show, list_id: lists(:one), id: @todo.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, list_id: lists(:one), id: @todo.to_param
    assert_response :success
  end

  test "should update todo" do
    put :update, list_id: lists(:one), id: @todo.to_param, todo: @todo.attributes
    assert_redirected_to list_todo_path(lists(:one), assigns(:todo))
  end

  test "should destroy todo" do
    assert_difference('Todo.count', -1) do
      delete :destroy, list_id: lists(:one), id: @todo.to_param
    end

    assert_redirected_to list_todos_path(lists(:one))
  end
end
