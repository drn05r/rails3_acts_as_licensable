module Rails3ActsAsLicensable
  class LicensesController < ApplicationController
  
    def index
      @licenses = License.all
    end

    def show
      @license = License.find(params[:id])

    end

    def new
      @license = License.new
    end

    def create
      params[:license][:user_id] = current_user.id
      @license = License.new(params[:license])
      if @license.save
        params[:license_attributes].each do |attrib,aval|
          @license_attribute = LicenseAttribute.new(:license => @license, :license_option_id => attrib)
          @license_attribute.save
        end
        flash[:notice] = 'License was successfully created.'
        redirect_to :action => 'index'
      else
        render :action => 'new'
      end
    end

    def edit
      @license = License.find(params[:id])
    end

    def update
      @license = License.find(params[:id])
      LicenseAttribute.destroy_all("license_id = #{params[:id]}")
      if params[:license_attributes]
        params[:license_attributes].each do |attrib,aval|
          @license_attribute = LicenseAttribute.new(:license => @license, :license_option_id => attrib)
          @license_attribute.save
        end
      end
      if @license.update_attributes(params[:license])
        flash[:notice] = 'License was successfully updated.'
        redirect_to :action => 'show', :id => @license
      else
        render :action => 'edit'
      end
    end

    def destroy
    #  if (Licensable.find_all_by_license_id(params[:id]).empty?) 
    #    License.find(params[:id]).destroy
    #    flash[:notice] = 'License was successfully deleted.'
    #  else
    #    flash[:error] = 'License could not be deleted because it is in use.'
    #  end
    #  redirect_to :action => 'index'
    end
  
    def update_license_form
      license = License.find(params[:license_id])   
      render(:partial => "licenses/view", :locals => {:license => license})
    end
  
    def update_license_info
      license = License.find_by_id(params[:license_id])
      render :partial => "licenses/view", :locals => { :license => license }
    end

  end
end
