#
#  TableDataSource.rb
#  RubyTwitter
#
#  Created by Marcus Crafter on 17/02/09.
#  Copyright (c) 2009 Red Artisan. All rights reserved.
#

require 'rubygems'
require 'twitter'
require 'osx/cocoa'

class TableDataSource < OSX::NSObject
  attr_accessor :tweets

  def numberOfRowsInTableView(tableView)
    @tweets = fetch_tweets
    puts @tweets.inspect
    @tweets.size
  end
  
  def tableView_objectValueForTableColumn_row(tableView, tableColumn, row)
    tweet = @tweets[row]
    
    if tableColumn.identifier == 'user'
      tweet.user.name
    elsif tableColumn.identifier == 'text'
      tweet.text
    else
      raise "Unknown table identifier requested: #{tableColumn.identifier}"
    end
  end
  
  private
  
    def fetch_tweets
      Twitter::Base.new('', '').timeline(:public)
    end

end
