class CreateRails3ActsAsLicensableLicensesTable < ActiveRecord::Migration
  def self.up
    create_table :rails3_acts_as_licensable_licenses do |t|
      t.string :unique_name, :null => false
      t.string :url, :null => false
      
      t.timestamps
    end
 end

 def self.down
    drop_table :rails3_acts_as_licensable_licenses
  end
end
