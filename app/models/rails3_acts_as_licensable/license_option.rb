module Rails3ActsAsLicensable
  class LicenseOption < ActiveRecord::Base
    attr_accessible :title, :description, :uri, :predicate

    validates_presence_of :title, :uri, :predicate
    validates_uniqueness_of :title, :uri
  end
end
