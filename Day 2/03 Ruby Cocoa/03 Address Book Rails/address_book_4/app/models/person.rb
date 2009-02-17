require 'osx/cocoa'
OSX.require_framework "AddressBook"

class Person

  def initialize(ab_person_or_hash = nil)
    if ab_person_or_hash.is_a?(OSX::ABPerson)
      @person_record = ab_person_or_hash
    else
      @person_record =  OSX::ABPerson.new
      @person_record.removeValueForProperty("uniqueId") if ab_person_or_hash.nil?
    end
    
    initialize_property_methods
    
    if ab_person_or_hash.is_a?(HashWithIndifferentAccess)
      update_attributes(ab_person_or_hash)
    end
  end
  
  def new_record?
    true unless @person_record.send(:valueForProperty, "uniqueId")
  end
  
  def save
    OSX::ABAddressBook.sharedAddressBook.addRecord(@person_record)
    return true
  end
  
  def to_param
    @person_record.send(:valueForProperty, "uniqueId")
  end
  
  def update_attributes(params)
    params.each do |param|
      self.send("#{param[0]}=".to_sym, param[1])
    end    
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
        
        define_method "#{property.titleize.underscore.gsub(" ", "_")}=" do |value|
          @person_record.send(:setValue_forProperty, value, property.to_s)
        end
      end
    end
  end

end
