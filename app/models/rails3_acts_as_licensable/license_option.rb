module Rails3ActsAsLicensable
  class LicenseOption < ActiveRecord::Base
    attr_accessible :unique_name, :uri, :predicate

    validates_presence_of :unique_name, :uri, :predicate
    validates_uniqueness_of :unique_name, :uri
  end
end
