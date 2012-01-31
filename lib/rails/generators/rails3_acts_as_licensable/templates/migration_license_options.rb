class CreateRails3ActsAsLicensableLicenseOptionsTable < ActiveRecord::Migration
  def self.up
    create_table :rails3_acts_as_licensable_license_options do |t|
      t.string :unique_name
      t.string :uri
      t.string :predicate
      t.timestamps
    end
  end

  def self.down
    drop_table :rails3_acts_as_licensable_license_options
  end
end
