require 'rubygems'
require 'twitter'

class Tweeter
  
  def public_tweets
    fetch_tweets.each do |s|
      puts "#{s.user.name}: #{s.text}"
    end
  end
  
  private
  
    def fetch_tweets
      Twitter::Base.new('', '').timeline(:public)
    end
  
end

Tweeter.new.public_tweets