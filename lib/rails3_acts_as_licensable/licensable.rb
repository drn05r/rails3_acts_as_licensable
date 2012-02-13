module Rails3ActsAsLicensable
  module Licensable
    extend ActiveSupport::Concern
    
    included do
    end
    
    module ClassMethods
      def acts_as_licensable
        return if acts_as_licensable?
        
        has_one :licensing, 
          :class_name => "Rails3ActsAsLicensable::Licensing", 
          :as => :licensable, 
          :dependent => :destroy, 
          :include => :license

        has_one :license, 
          :class_name => "Rails3ActsAsLicensable::License", 
          :through => :licensing, 
          :readonly => true
          
        # accepts_nested_attributes_for :licensing
        
        send(:extend, Rails3ActsAsLicensable::Licensable::SingletonMethods)
        send(:include, Rails3ActsAsLicensable::Licensable::InstanceMethods)
      end
      
      def acts_as_licensable?
        false
      end
    end
    
    module SingletonMethods
      def acts_as_licensable?
        true
      end
    end
    
    module InstanceMethods
      def licensed?
        !license.nil?
      end
    end
  end
end

ActiveRecord::Base.send(:include, Rails3ActsAsLicensable::Licensable)
