# 01 Getting Started
## Setting up Rails
Step 1: Install the latest version of rails (3.1rc4)

	$ gem install rails --pre

Step 2: Generate a new rails application

	$ rails new todolist

Check out all of the code generated for us. It follows the conventions discussed earlier and even runs bundler for us to ensure we are ready to go. 

## Welcome Aboard!

The rails application runs out of the box. 

	$ cd todolist
	$ rails server

Visit locahost:3000 in your browser of choice.

## Scaffolding.

The quickest (and dirtiest) way to get a rails app doing something useful is to use scaffolding. While you're learning the framework this is a great tool. Once you get your head around rails you will find yourself using this less and less.

	$ rails generate scaffold todo title:string note:text due_by:datetime complete:boolean

The console output will let you know which files it has created. There will be a migration file, a model file, tests, a restful controller, views, a helper file, css and javascript files. 

Have a look at each generated file to get an understanding of what it does. Scaffolding generates a lot of files that may never use, hence their dwindling use as you understnd rails.

## Migrations

Before you can do anything with the generated code you need to run the migration that was generated.

	$ rake db:migrate

This creates a table in your database with the specified columns from the scaffold command plus a few extras.

	t.timestamps

Timestamps is a shorthand for creating two datetime fields: created_at, updated_at.

ActiveRecord (the default ORM in rails) will fill these in for you as you create and update records.

## REST in Action

You've run the scaffold, generated a bunch of code, migrated your database. So what have you actually achieved?

	$ rails server

Visit http://localhost:3000/todos

Fully working CRUD.

You can create, read, update and delete todo items.

## Testing

So far rails has generated a lot of code for you, you can be pretty sure it works. Ruby developers like writing tests, rails makes this easy.

	$ rake test

You just ran the generated tests, rails is awesome like that. 

TDD says we should write failing tests before writing code, so lets write a simple validation test:

	test "title should be present" do
    	todo = Todo.new
    	assert !todo.valid?
    
    	todo.title = "My Title"
    	assert todo.valid?
 	end

Run the tests again, and this should fail. To make it pass we can use one of the built in ActveRecord validation helpers.

	validates_presence_of :title

Try it out in the browser.

## More Testing

One big todo list isn't very appealing. Most people want to create some kind of bucket to separate out tasks. Lets gets a list to hold our todos.

	$ rails generate scaffold list title:string

We should probably validate that our lists have a title and that it is unique. ActiveRecord has another helpful validation to ensure that entries are unique. 

	validates_uniqueness_of :title

You should definitely add a database level contraint for that in a production system, but we'll skip that for now.

It's up to you to write failing tests for the list model.

## Associations

Now lets link our todo and list models with an association. 

