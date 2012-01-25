module Rails3ActsAsLicensable
  class LicenseAttribute < ActiveRecord::Base
    belongs_to :license, :class_name => "Rails3ActsAsLicensable::License"
    belongs_to :license_option, :class_name => "Rails3ActsAsLicensable::LicenseOption"

    validates_presence_of :license_option_id, :license_id
  end
end
