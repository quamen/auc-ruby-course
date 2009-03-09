#
# This file contains the DSL magic to read the mini domain specific language in crawl.rb
#


require 'rubygems'
require 'activesupport' # for cattr_accessor
require 'dsl_accessor'

class Object
  def crawl(&block)
    Crawl.current = Crawl.new(&block)
  end
end

class Crawl
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

class Pub
  dsl_accessor :name
  
  def initialize(options = {}, &block)
    @beers = []
    options.each { |k, v| self.send k, v }
    instance_eval &block
  end
  
  def address(&block)
    @address = Address.new(&block)
  end
  
  def beers(&block)
    instance_eval &block
  end
  
  def crowd(options = {})
    @crowd = options[:mood]
  end
  
  def method_missing(beer)
    @beers << Beer.new(beer)
  end
  
end

class Bar
  dsl_accessor :name
  
  def initialize(options = {}, &block)
    @cocktails = []
    options.each { |k, v| self.send k, v }
    instance_eval &block
  end
  
  def address(&block)
    @address = Address.new(&block)
  end
  
  def cocktails(&block)
    instance_eval &block
  end
    
  def crowd(options = {})
    @crowd = options[:mood]
  end
  
  def method_missing(beer)
    @cocktails << Cocktail.new(beer)
  end
  
end

class Address
  dsl_accessor :street, :lat, :lng
  
  def initialize(&block)
    instance_eval &block
  end
end

class Beer
  def initialize(name)
    @name = name
  end
end

class Cocktail
  def initialize(name)
    @name = name
  end
end




require 'crawl'

puts Crawl.current.inspect