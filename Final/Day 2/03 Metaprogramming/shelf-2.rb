# Version 2
#
# - Define classes representing our dvd and book
# - Define initializer, send all provided options to the instance
# - Use dsl_accessor for nicer non '=' setter method for options
#
# - Inspecting contents now works fine


require 'rubygems'
require 'active_support/all' # for cattr_accessor
require 'dsl_accessor'
require 'pp'

class Shelf
  attr_accessor  :items
  cattr_accessor :current

  def initialize(&block)
    @items = []
    instance_eval &block
  end

  def dvd(options, &block)
    @items << Dvd.new(options, &block)
  end

  def book(options, &block)
    @items << Book.new(options, &block)
  end

end

class Dvd
  dsl_accessor :name, :description, :actors, :year

  def initialize(options = {}, &block)
    options.each { |k, v| self.send k, v }
    instance_eval &block
  end

end

class Book
  dsl_accessor :name, :isbn, :description, :authors, :year

  def initialize(options = {}, &block)
    options.each { |k, v| self.send k, v }
    self.instance_eval &block
  end

end

class Object
  def shelf(&block)
    Shelf.current = Shelf.new(&block)
  end
end

require 'myshelf'

pp Shelf.current