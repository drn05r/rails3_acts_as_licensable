module Rails3ActsAsLicensable
  class License < ActiveRecord::Base
    attr_accessible :unique_name, :url

    validates_presence_of :unique_name, :url
    validates_uniqueness_of :unique_name, :url
  
    has_many :license_attributes, 
             :dependent => :destroy

  end  
end
