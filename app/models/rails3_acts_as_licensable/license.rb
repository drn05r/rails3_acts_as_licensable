module Rails3ActsAsLicensable
  class License < ActiveRecord::Base
    attr_accessible :unique_name, :title, :url

    validates_presence_of :unique_name, :title, :url
    validates_uniqueness_of :unique_name, :title, :url
  
    has_many :license_attributes, 
             :dependent => :destroy

    def self.find_license_options_set(license)
      license_options = Array.new
      unless license.nil?
    	license.license_attributes.each do |license_attribute|
          license_options << license_attribute.license_option
        end
      end
      return license_options
    end
           
  end  
end
