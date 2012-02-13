module Rails3ActsAsLicensable
  class LicenseOption < ActiveRecord::Base
    attr_accessible :unique_name, :uri, :predicate

    validates_presence_of :unique_name, :uri, :predicate
    validates_uniqueness_of :unique_name, :uri
    
    has_many :license_attributes, 
             :class_name => "Rails3ActsAsLicensable::LicenseAttribute", 
             :inverse_of => :license_option,
             :dependent => :destroy
             
    has_many :licenses,
             :class_name => "Rails3ActsAsLicensable::License",
             :through => :license_attributes,
             :source => :license,
             :readonly => true
    
    default_scope order(arel_table[:unique_name])
    
    def title
      I18n.t("license_options.#{read_attribute(:unique_name)}.title")
    end
    
    def description
      I18n.t("license_options.#{read_attribute(:unique_name)}.description")
    end
    
  end
end
