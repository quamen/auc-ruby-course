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
  
  ib_outlet :table_view
  
  def numberOfRowsInTableView(tableView)
    @tweets = fetch_tweets
    puts @tweets.inspect
    @tweets.size
  end
  
  def tableView_objectValueForTableColumn_row(tableView, tableColumn, row)
  end
  
  private
  
    def fetch_tweets
      Twitter::Client.new.public_timeline
    end

end
