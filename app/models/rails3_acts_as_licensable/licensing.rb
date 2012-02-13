module Rails3ActsAsLicensable
  class Licensing < ActiveRecord::Base
    attr_accessible :license_id
    
    validates_presence_of :license_id# , :licensable_type, :licensable_id
    
    belongs_to :license, 
      :class_name => "Rails3ActsAsLicensable::License",
      :inverse_of => :licensings,
      :touch => false
      
    has_many :license_attributes,
      :class_name => "Rails3ActsAsLicensable::LicenseAttribute",
      :through => :license,
      :source => :license_attributes,
      :readonly => true
      
    has_many :license_options,
      :class_name => "Rails3ActsAsLicensable::LicenseOption",
      :through => :license_attributes,
      :source => :license_option,
      :readonly => true
      
    belongs_to :licensable, 
      :class_name => "Rails3ActsAsLicensable::Licensable", 
      :polymorphic => true,
      :touch => false
    
  end
end
