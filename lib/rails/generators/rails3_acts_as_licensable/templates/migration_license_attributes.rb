class CreateRails3ActsAsLicensableLicenseAttributesTable < ActiveRecord::Migration
  def self.up
    create_table :rails3_acts_as_licensable_license_attributes do |t|
      t.integer :license_id
      t.integer :license_option_id
      t.timestamps
    end
  end

  def self.down
    drop_table :rails3_acts_as_licensable_license_attributes
  end
end
