class CreateRails3ActsAsLicensableLicensingsTable < ActiveRecord::Migration
  def self.up
    create_table :rails3_acts_as_licensable_licensings do |t|
      t.references :licensable, :null => false, :polymorphic => true
      t.references :license, :null => false
      
      t.timestamps
    end
    
    # add_index :rails3_acts_as_licensable_licensings, [:licensable_type, :licensable_id]
    # add_index :rails3_acts_as_licensable_licensings, :license_id
  end

  def self.down
    # remove_index :rails3_acts_as_licensable_licensings, [:licensable_type, :licensable_id]
    # remove_index :rails3_acts_as_licensable_licensings, :license_id
    
    drop_table :rails3_acts_as_licensable_licensings
  end
end
