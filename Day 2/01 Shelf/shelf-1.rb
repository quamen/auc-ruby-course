# Version 1
#
# - Including rubygems/active for class accessor
# - Defined a base Shelf class which will hold all of the items sitting on the shelf.
# - Instance eval'd the block passed to the constructor, with a few place holder methods for handling the definitions of dvd and book.
# - Open up Object, add a method for defining a shelf in global namespace, for the moment, lets store the result in a class variable
# - Require/parse our data
# - Inspect the shelf
#


require 'rubygems'
require 'active_support/all' # for cattr_accessor
require 'pp'

class Shelf
  attr_accessor  :items
  cattr_accessor :current

  def initialize(&block)
    @items = []
    instance_eval &block
  end

  def dvd(options = {}); end
  def book(options = {}); end
end

class Object
  def shelf(&block)
    Shelf.current = Shelf.new(&block)
  end
end

require 'myshelf'

puts Shelf.current