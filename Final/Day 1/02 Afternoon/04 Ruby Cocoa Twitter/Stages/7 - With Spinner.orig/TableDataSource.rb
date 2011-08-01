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
  
  ib_outlet :table_view, :spinner
  ib_action :refresh
  
  def refresh(sender)
    @spinner.startAnimation(sender)
    @table_view.reloadData
    @spinner.stopAnimation(sender)
  end

  def numberOfRowsInTableView(tableView)
    @tweets = fetch_tweets
    #puts @tweets.inspect
    @tweets.size
  end
  
  def tableView_objectValueForTableColumn_row(tableView, tableColumn, row)
    tweet = @tweets[row]
    
    if tableColumn.identifier == 'user'
      #tweet.user.name
      OSX::NSImage.alloc.initByReferencingURL(OSX::NSURL.URLWithString(tweet.user.profile_image_url))
    elsif tableColumn.identifier == 'text'
      tweet.text
    else
      raise "Unknown table identifier requested: #{tableColumn.identifier}"
    end
  end
  
  private
  
    def fetch_tweets
      Twitter::Client.new.public_timeline
    end

end