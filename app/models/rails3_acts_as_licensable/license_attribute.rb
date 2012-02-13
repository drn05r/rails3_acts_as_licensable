module Rails3ActsAsLicensable
  class LicenseAttribute < ActiveRecord::Base
    attr_accessible :license_id, :license_option_id
    
    validates_presence_of :license_id, :license_option_id
    
    belongs_to :license, 
      :class_name => "Rails3ActsAsLicensable::License",
      :inverse_of => :license_attributes,
      :touch => false
      
    belongs_to :license_option, 
      :class_name => "Rails3ActsAsLicensable::LicenseOption",
      :inverse_of => :license_attributes,
      :touch => false
      
    default_scope includes(:license_option).joins(:license_option).order(Rails3ActsAsLicensable::LicenseOption.arel_table[:predicate], Rails3ActsAsLicensable::LicenseOption.arel_table[:unique_name])
      
    delegate :title, :description, :unique_name, :uri, :predicate, :to => :license_option
    
  end
end
