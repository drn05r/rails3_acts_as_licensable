module Rails3ActsAsLicensable
  module LicensesHelper
    def license_icon_tag(license, html_options = {})
      html_options.reverse_merge!({
        :alt    => license.title,
        :title  => license.title,
        :border => 0,
        :class  => "license_icon",
      })
      
      image_tag(url_for_license_icon(license, html_options[:size]), html_options)
    end
    
    def link_to_license_icon_tag(license, with_locale = true, icon_html_options = {}, html_options = {})
      html_options.reverse_merge!({
        :class  => "external",
        :target => "_blank",
        :alt    => license.title,
        :title  => license.title,
      })
      
      link_to(url_for_license(license, with_locale), html_options) do
        license_icon_tag(license, icon_html_options)
      end
    end
    
    def url_for_license(license, with_locale = true)
      with_locale ? license.url_with_locale : license.url
    end
    
    def url_for_license_icon(license, size = nil)
      license.icon_url(size.presence || Rails3ActsAsLicensable::LicensesController.license_icon_size)
    end
  end
end
