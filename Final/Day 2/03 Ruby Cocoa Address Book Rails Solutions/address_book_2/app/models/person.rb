require 'osx/cocoa'
OSX.require_framework "AddressBook"

class Person

  def initialize(person_record)
    @person_record = person_record
  end

  def self.find(person_id)
    people = OSX::ABAddressBook.sharedAddressBook.people
    people = people.collect { |person| Person.new(person) }
  end
  
  def method_missing(method, *args)
    self.class_eval do
      define_method "#{method}" do
        @person_record.send(:valueForProperty, method.to_s.capitalize)
      end
    end
    
    self.send("#{method}".to_sym)
   end
end