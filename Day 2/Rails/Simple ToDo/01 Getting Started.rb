# 01 Getting Started
# 
# Step 1:
# 
   $ rails todo
#   
#   Check out all the code I didn't just write!
# 
#   Oh and it already runs
# 
   $ script/server
#   
# Step 2:
# 
   $ script/generate scaffold todo title:string note:text due_by:datetime complete:boolean
#   
#   What?
#   
#   Migration => db/migrate/*_create_todos.rb
#   
#     Explain timestamps. 
#     t.timestamps
#   
#   Model => app/models/todo.rb
#   
#   Helper => app/helpers/todos_helper.rb
#   
#   Controller => app/conotrollers/todos_controller
#   
#   Views => app/views/todos/*.html.erb
#   
#   Layout => app/views/layouts/todos.html.erb
#   
#   Routes => config/routes.rb
#   
# Step 3:
# 
  $ rake db:migrate
#   
#   What? Just ran migration against development database
#   
#   config/database.yml
#   
#   sqlite3 by default.
#   
  $ script/server
#   
#   http://localhost:3000/todos
#   
#   Fully working crud!
#   
# Step 4:
# 
#   First we write a test
#   
  def test_invalid_with_emtpy_attributes
    todo = Todo.new
    assert !todo.valid?
    
    assert todo.errors.invalid?(:title)
    assert todo.errors.invalid?(:list_id)
    
    assert_equal ActiveRecord::Errors.default_error_messages[:blank], todo.errors.on(:title)
    assert_equal ActiveRecord::Errors.default_error_messages[:blank], todo.errors.on(:list_id)
  end
# 
#   Validations
#   
#   app/models/todo.rb
#   
   validates_presence_of :title
#   
#   Lets try it again without restarting the server.
#   
#   It works. That's awesome!
#   
# Step 5:
# 
#   Create higher level container for todos
#   
#   How about a list?
#   
  $ script/generate scaffold list title:string
#   
#   Same deal as with todos.
#   
#   Lets add some tests
#   
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
#   
#   Lets add validations to the list title. 
#   
  validates_presence_of :title
  validates_uniqueness_of :title
#   
#   There are heaps of validation methods available. You can even create your own.
#   
# Step 6:
# 
#   List have many todos
#   Todos belong to a list
#   
  $ script/generate migration add_list_id_to_todos
#   
  def self.up
    add_column :todos, :list_id, :integer
  end

  def self.down
    remove_column :todos, :list_id
  end
#   
#   Nothing has changed from a UI/Controller perspective
#   
#   The relationships exist in our models though.
#   
  def test_fixture_todos_should_belong_to_the_same_list
    assert_equal todos(:one).list, todos(:two).list
  end
  
  def test_fixture_todo_should_be_able_to_access_list_title
    assert_equal todos(:one).list.title, "MyString"
  end
  
  def test_fixture_list_one_should_contain_two_todos
    assert_equal lists(:one).todos.length, 2
  end
  
  def test_fixture_list_two_should_contain_zero_todos
    assert_equal lists(:two).todos.length, 0
  end
#   
  script/console
# 
# Step 7:
# 
#   Nested Routes
#   
#   Todo required to have a list
#   
  validates_presence_of :list_id
#   
#   this is nicer: validates_presence_of :title, :list_id
#   
#   config/routes.rb
#   
  map.resources :lists
# 
  map.resources :todos
#   
#   becomes
#   
  map.resources :lists, :has_many => [:todos]
#   
#   localhost:3000/todos no longer works.
#   
#   It is now nested
#   
#   http://localhost:3000/lists/1/todos
#   
# Step 8:
# 
#   Fix html
#   
#   Error: todo_path no longer exists
#   
   $ rake routes
#   
#   In doing so we need to set the @list variable
#   
  private
  
  def find_list
    @list = List.find(params[:list_id])
  end
  
  and
  
  before_filter :find_list
#   
# Step 9:
# 
#   Error: list can't be blank
#   
#   We are not scoping our controller methods correctly
#   
#   List property isn't automatically set. Lets change the controller code for todo
#   
  @list.todos
#   
# Step 10:
# 
#   Redirection.
#   
#   Our controller methods still redirect to the old todo_paths.
# 
# Step 11:
#   Clean up the view code.
#   
#   PARTIALS!
#   
  <%= render :partial => 'form', :object => f #%>
#   
# Step 12:
# 
#   RubyCocoa!
#   
#   Each of our todos should really be assigned to a person. So that we know who will take care of it. Lets build ourselves a Person class.
#   
#   Migration!
#   
#   class AddPersonToTodoTable < ActiveRecord::Migration
    def self.up
      add_column :todos, :person_id, :string
    end

    def self.down
      remove_column :todos, :person_id
    end
#   
#   Form Adjustment!
#   
  <p>
    <%= form.label :person_id %><br />
    <%= form.select(:person_id, Person.find_all.collect {|p| [p.display_for_dropdown, p.id]} )%>
  </p>
#   
#   The Class
#   
  class Person

    require 'osx/cocoa' 
    include OSX
    OSX.require_framework "AddressBook"

    def new_record?
      false
    end

    def initialize(person_record)
      @person_record = person_record
    end

    def self.find_all
      address_book = ABAddressBook.sharedAddressBook.people.copy

      people = Array.new
      for person in address_book
        people << Person.new(person)
      end

      people
    end

    def self.find(person_id)
      @person_record = ABAddressBook.sharedAddressBook.recordForUniqueId(person_id).copy
      return self
    end

    def id
      valueForPropertyWithKey('uniqueId')
    end

    def display_for_dropdown
      "#{valueForPropertyWithKey('First')} #{valueForPropertyWithKey('Last')}"
    end

    def to_param
      id
    end

    def valueForPropertyWithKey(property)
      @person_record.valueForProperty(property) 
    end
  end


  # AIMInstant
  # Organization
  # ABRelatedNames
  # RemoteLocation
  # Nickname
  # ABDepartment
  # Note
  # Last
  # Creation
  # Email
  # MaidenName
  # FirstPhonetic
  # JabberInstant
  # Middle
  # Modification
  # HomePage
  # ABPersonFlags
  # Suffix
  # URLs
  # calendarURIs
  # Address
  # Phone
  # Title
  # LastPhonetic
  # YahooInstant
  # First
  # Birthday
  # MSNInstant
  # ABDate
  # UID
  # MiddlePhonetic
  # ICQInstant
  # JobTitle
  # 
  