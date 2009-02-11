#!/usr/bin/env ruby

require 'osx/cocoa'
include OSX

class AppDelegate < NSObject

  def applicationDidFinishLaunching(aNotification)
    puts "#{aNotification.name} makes me say: Hello, World!"
  end

end

NSApplication.sharedApplication
NSApp.setDelegate(AppDelegate.alloc.init)
NSApp.run