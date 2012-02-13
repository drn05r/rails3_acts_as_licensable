module Rails3ActsAsLicensable
  class LicensesController < Rails3ActsAsLicensable::ApplicationController
    cattr_reader :license_config
    @@license_config = YAML::load(File.open("config/rails3_acts_as_licensable.yml"))
    
    def self.license_icon_size
      @@license_config["license_icon_size"]
    end
  
    def index
      @licenses = Rails3ActsAsLicensable::License.all
    end

    def show
      @license = Rails3ActsAsLicensable::License.find(params[:id])
    end
  end
end
