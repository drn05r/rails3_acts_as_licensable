module Rails3ActsAsLicensable
  class LicenseAttributesController < ApplicationController

    def destroy
        LicenseAttribute.find(params[:id]).destroy
    end

  end
end
