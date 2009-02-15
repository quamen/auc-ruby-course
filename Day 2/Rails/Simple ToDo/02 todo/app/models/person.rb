class Person

  require 'osx/cocoa' 
  include OSX
  OSX.require_framework "AddressBook"
  
  def new_record?
    false
  end
  
  def initialize(person_record)
    @person_record = person_record
  end

  def self.find_all
    address_book = ABAddressBook.sharedAddressBook.people.copy

    people = Array.new
    for person in address_book
      people << Person.new(person)
    end

    people
  end
  
  def self.find(person_id)
    @person_record = ABAddressBook.sharedAddressBook.recordForUniqueId(person_id).copy
    return self
  end
  
  def id
    valueForPropertyWithKey('uniqueId')
  end
  
  def display_for_dropdown
    "#{valueForPropertyWithKey('First')} #{valueForPropertyWithKey('Last')}"
  end
  
  def to_param
    id
  end
  
  def valueForPropertyWithKey(property)
    @person_record.valueForProperty(property) 
  end
end


# AIMInstant
# Organization
# ABRelatedNames
# RemoteLocation
# Nickname
# ABDepartment
# Note
# Last
# Creation
# Email
# MaidenName
# FirstPhonetic
# JabberInstant
# Middle
# Modification
# HomePage
# ABPersonFlags
# Suffix
# URLs
# calendarURIs
# Address
# Phone
# Title
# LastPhonetic
# YahooInstant
# First
# Birthday
# MSNInstant
# ABDate
# UID
# MiddlePhonetic
# ICQInstant
# JobTitle
# 
