class AddRails3ActsAsLicensableLicenses < ActiveRecord::Migration
  def self.up
    require 'yaml'
    @license_config = YAML::load(File.open("config/rails3_acts_as_licensable.yml"))
    license_option_recs = Hash.new
    @license_config['license_options'].each do |lo_un, license_option|
      license_option_recs[lo_un] = Rails3ActsAsLicensable::LicenseOption.create(license_option)
      license_option_recs[lo_un].unique_name=lo_un
      license_option_recs[lo_un].save!
    end
    @license_config['licenses'].each do |license_un, license|
      license_attributes = license['attributes']
      license.delete('attributes')
      license_rec = Rails3ActsAsLicensable::License.create(license)
      license_rec.unique_name = license_un
      license_rec.save!
      unless license_attributes.nil? then
        license_attributes.split(",").each do |lic_attribute|
          license_attribute = Rails3ActsAsLicensable::LicenseAttribute.new
          license_attribute.license=license_rec
          license_attribute.license_option=license_option_recs[lic_attribute]
          license_attribute.save
	end
      end
    end
  end

  def self.down
    Rails3ActsAsLicensable::License.delete_all
    Rails3ActsAsLicensable::LicenseOption.delete_all
  end
end
