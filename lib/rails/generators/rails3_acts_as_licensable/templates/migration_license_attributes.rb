class CreateRails3ActsAsLicensableLicenseAttributesTable < ActiveRecord::Migration
  def self.up
    create_table :rails3_acts_as_licensable_license_attributes do |t|
      t.references :license, :null => false
      t.references :license_option, :null => false
      
      t.timestamps
    end
    
    # add_index :rails3_acts_as_licensable_license_attributes, :license_id
    # add_index :rails3_acts_as_licensable_license_attributes, :license_option_id
  end

  def self.down
    # remove_index :rails3_acts_as_licensable_license_attributes, :license_id
    # remove_index :rails3_acts_as_licensable_license_attributes, :license_option_id
    
    drop_table :rails3_acts_as_licensable_license_attributes
  end
end
