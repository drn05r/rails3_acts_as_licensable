module Rails3ActsAsLicensable
  class LicensesController < ApplicationController
  
    def index
      @license_config = YAML::load(File.open("config/rails3_acts_as_licensable.yml"))
      @licenses = License.all
    end

    def show
      @license_config = YAML::load(File.open("config/rails3_acts_as_licensable.yml"))
      @license = License.find(params[:id])
    end

  end
end
