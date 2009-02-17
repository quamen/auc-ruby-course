require 'osx/cocoa'
OSX.require_framework "AddressBook"

class Person

  def initialize(person_record)
    @person_record = person_record
    initialize_property_methods
  end
  

  
  def to_param
    @person_record.send(:valueForProperty, "uniqueId")
  end

  def self.find(person_id)
    if person_id == :all
      OSX::ABAddressBook.sharedAddressBook.people.collect { |person| Person.new(person)}
    else
      Person.new(OSX::ABAddressBook.sharedAddressBook.recordForUniqueId(person_id.to_s))
    end
  end
    
  def initialize_property_methods
    @person_record.class.properties.each do |property|
      self.class_eval do
        define_method "#{property.titleize.underscore.gsub(" ", "_")}" do
          @person_record.send(:valueForProperty, property.to_s)
        end
      end
    end
  end

end
