#!/usr/bin/env ruby

require 'osx/cocoa'
OSX.require_framework "AddressBook"
include OSX

class AppDelegate < NSObject

  def applicationDidFinishLaunching(aNotification)
    puts ABAddressBook.sharedAddressBook.me
    
    puts ABAddressBook.sharedAddressBook.groups.first.members.first
    
    puts ABAddressBook.sharedAddressBook.groups.first.members.first.valueForProperty('Birthday')
  end

end

NSApplication.sharedApplication
NSApp.setDelegate(AppDelegate.alloc.init)
NSApp.run