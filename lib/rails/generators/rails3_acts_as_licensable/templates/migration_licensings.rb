class CreateRails3ActsAsLicensableLicensingsTable < ActiveRecord::Migration
  def self.up
    create_table :rails3_acts_as_licensable_licensings do |t|
      t.references :licensable, :polymorphic => true
      t.integer :license_id
      t.timestamps
    end
  end

  def self.down
    drop_table :rails3_acts_as_licensable_licensings
  end
end
