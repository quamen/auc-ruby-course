# Version 4
#
# Even DRYer
#
# Book and DVD classes are just holders of data, we can DRY this up further
# - define another Object method for defining new Item types on the fly
#   - even easier to define new Shelf item types
#


require 'rubygems'
require 'activesupport' # for cattr_accessor
require 'dsl_accessor'

class Object
  def shelf(&block)
    Shelf.current = Shelf.new(&block)
  end
  
  def item(name, *properties)
    klass = Object.const_set(name.to_s.capitalize, Class.new(Item))
    klass.dsl_accessor *properties
  end
end

class Shelf
  attr_accessor  :items
  cattr_accessor :current
  
  def initialize(&block)
    @items = []
    instance_eval &block
  end
  
  def method_missing(klass, *args, &block)
    @items << klass.to_s.capitalize.constantize.new(*args, &block)
  end
    
end

class Item
  def initialize(options = {}, &block)
    options.each { |k, v| self.send k, v }
    instance_eval &block
  end
end

item :dvd, :name, :description, :actors, :year
item :book, :name, :isbn, :description, :authors, :year
item :cd, :name, :author, :description, :year

# Example with business logic methods
#
# item :camera, :name, :brand, :description, :year do
#   def to_s; name; end
# end
#

require 'myshelf'

puts Shelf.current.inspect