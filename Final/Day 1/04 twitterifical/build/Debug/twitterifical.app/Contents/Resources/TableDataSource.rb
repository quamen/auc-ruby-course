#
#  TableDataSource.rb
#  twitterifical
#
#  Created by Gareth Townsend on 20/02/09.
#  Copyright (c) 2009 Touchable Software. All rights reserved.
#

require 'osx/cocoa'
require 'rubygems'
require 'twitter'

class TableDataSource < OSX::NSObject
  attr_accessor :tweets
  
  ib_outlet :table_view, :spinner
  ib_action :refresh
  
  def refresh(sender)
    @spinner.startAnimation(sender)
    @spinner.setAlphaValue(1.0) # fade out
    @table_view.reloadData
    @spinner.setAlphaValue(0.0) # fade in
    @spinner.stopAnimation(sender)
  end

  def numberOfRowsInTableView(tableView)
    @tweets = fetch_tweets
    #puts @tweets.inspect
    @tweets.size
  end

  def tableView_objectValueForTableColumn_row(tableView, tableColumn, row)
    tableColumn.identifier.split(".").inject(@tweets[row]) {|t, v| t = t.send(v.to_sym) }
  end
  
  private
  
  def fetch_tweets
    Twitter::Base.new('', '').timeline(:public)
  end
end

class Twitter::Status
  def ns_profile_image
    OSX::NSImage.alloc.initByReferencingURL(OSX::NSURL.URLWithString(self.user.profile_image_url))
  end
end
