
class Bookshelf
  attr_accessor :items

  def initialize
    @items = []
  end

  def add(item)
    @items << item
  end

  alias << add

  def contents
    @items.collect { |item| item.description }
  end

end


class Book
  attr_accessor :title, :pagecount, :publisher

  def initialize(title, pagecount, publisher = 'Unknown')
    @title = title
    @publisher = publisher
    @pagecount = pagecount
  end

  def description
    "#{self.class.name}: #{@title}, published by #{@publisher}, #{@pagecount} pages"
  end

end

require 'date'


class Dvd
  attr_accessor :title, :director, :release_date

  def initialize(title, director, release_date = Date.today)
    @title, @director, @release_date = title, director, release_date
  end

  def description
    "#{self.class.name}: #{title}, directed by #{director}, released #{release_date}"
  end

end

# add price to each sub-object
# sum all items together

# class Wine
#   attr_accessor :price

#   def sum
#     @items.inject(0) { |sum, item| sum + item.price }
#   end
# end

class Magazine < Book
  attr_accessor :issue

  def initialize(title, issue, pagecount, publisher = 'Unknown')
    super title, pagecount, publisher
    @issue = issue
  end

  def description
    super << ", issue #{issue}"
  end

end


shelf = Bookshelf.new
shelf << Book.new('The Ruby Programming Language', 350, 'Addison Wesley')
shelf << Book.new('The Ruby Way', 201)
shelf << Dvd.new('Inception', 'Christopher Nolan')
shelf << Magazine.new('Cycling Australia', 10, 101, 'XYZ')

puts shelf.contents
