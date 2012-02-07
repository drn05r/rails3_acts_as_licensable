module Rails3ActsAsLicensable
  class Licensing < ActiveRecord::Base
    belongs_to :license, :class_name => "Rails3ActsAsLicensable::License"
    belongs_to :licensable, :class_name => Rails3ActsAsLicensable::Licensable, :polymorphic => true

    validates_presence_of :license_id
  end
end
