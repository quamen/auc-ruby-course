# Version 3
#
# DRY things up a little
#
# - Define a base Item class that includes the initializer
#   - makes it simple to define new items, eg. cd.
# - Updated to use method_missing in Shelf automatically instantiate Items
#   - makes it easier to define new items, eg. cd.
#

require 'rubygems'
require 'activesupport' # for cattr_accessor
require 'dsl_accessor'

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

class Dvd < Item
  dsl_accessor :name, :description, :actors, :year
end

class Book < Item
  dsl_accessor :name, :isbn, :description, :authors, :year
end

class Cd < Item
  dsl_accessor :name, :author, :description, :year
end

class Object
  def shelf(&block)
    Shelf.current = Shelf.new(&block)
  end
end

require 'myshelf'

puts Shelf.current.inspect