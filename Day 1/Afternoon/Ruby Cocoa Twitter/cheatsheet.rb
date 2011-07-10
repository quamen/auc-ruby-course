#
#  TableDataSource.rb
#  RubyTwitter
#

require 'rubygems'
require 'twitter'
require 'osx/cocoa'

class TableDataSource < OSX::NSObject

  def numberOfRowsInTableView(tableView)
  end

  def tableView_objectValueForTableColumn_row(tableView, tableColumn, row)
  end

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



OSX::NSImage.alloc.initByReferencingURL(OSX::NSURL.URLWithString(tweet.user.profile_image_url))



def refresh(sender)
  @spinner.startAnimation(sender)
  @tweets = Twitter::Client.new.public_timeline
  @spinner.stopAnimation(sender)
end





def refresh(sender)
  @spinner.animate(sender) do
    @table_view.reloadData
  end
end

class OSX::NSProgressIndicator < OSX::NSView

  def animate(sender)
    self.startAnimation(sender)
    yield if block_given?
    self.stopAnimation(sender)
  end

end






