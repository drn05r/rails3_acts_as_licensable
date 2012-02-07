module Rails3ActsAsLicensable
  module Licensable
    def is_licensable
        has_one :licensing, :class_name => "Rails3ActsAsLicensable::Licensing", :as => :licensable, :dependent => :destroy, :include => :license
        has_one :license, :class_name => "Rails3ActsAsLicensable::License", :through => :licensing, :source => :license
        include InstanceMethods
    end

    module InstanceMethods
      def licensable?
        true
      end
    end

  end
  ActiveRecord::Base.extend Licensable
end

