class CreateRails3ActsAsLicensableLicenseOptionsTable < ActiveRecord::Migration
  def self.up
    create_table :rails3_acts_as_licensable_license_options do |t|
      t.string :unique_name, :null => false
      t.string :uri, :null => false
      t.string :predicate, :null => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :rails3_acts_as_licensable_license_options
  end
end
