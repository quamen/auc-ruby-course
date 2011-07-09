class TodosController < ApplicationController
  before_filter :find_list
  
  # GET lists/1/todos
  # GET lists/1/todos.json
  def index
    @todos = @list.todos.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @todos }
    end
  end

  # GET lists/1/todos/1
  # GET lists/1/todos/1.json
  def show
    @todo = @list.todos.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @todo }
    end
  end

  # GET lists/1/todos/new
  # GET lists/1/todos/new.json
  def new
    @todo = @list.todos.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @todo }
    end
  end

  # GET lists/1/todos/1/edit
  def edit
    @todo = @list.todos.find(params[:id])
  end

  # POST lists/1/todos
  # POST lists/1/todos.json
  def create
    @todo = @list.todos.new(params[:todo])

    respond_to do |format|
      if @todo.save
        format.html { redirect_to list_todo_path(@list, @todo), notice: 'Todo was successfully created.' }
        format.json { render json: @todo, status: :created, location: @todo }
      else
        format.html { render action: "new" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT lists/1/todos/1
  # PUT lists/1/todos/1.json
  def update
    @todo = @list.todos.find(params[:id])

    respond_to do |format|
      if @todo.update_attributes(params[:todo])
        format.html { redirect_to list_todo_path(@list, @todo), notice: 'Todo was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE lists/1/todos/1
  # DELETE lists/1/todos/1.json
  def destroy
    @todo = @list.todos.find(params[:id])
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to list_todos_url(@list) }
      format.json { head :ok }
    end
  end
  
  private
  
  def find_list
    @list = List.find(params[:list_id])
  end
end
