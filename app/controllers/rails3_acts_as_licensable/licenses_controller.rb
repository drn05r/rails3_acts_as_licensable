module Rails3ActsAsLicensable
  class LicensesController < ApplicationController
  
    def index
      @licenses = License.all
    end

    def show
      @license = License.find(params[:id])

    end

  end
end
