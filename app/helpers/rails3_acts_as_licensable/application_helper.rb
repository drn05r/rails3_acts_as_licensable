module Rails3ActsAsLicensable
  module ApplicationHelper

    def strip_html(str, preserve_tags=[])
      str = str.strip || ''
      preserve_arr = preserve_tags.join('|') << '|\/'
      str.gsub(/<(\/|\s)*[^(#{preserve_arr})][^>]*>/,'')
    end

    def license_url_locale
        return "deed.#{I18n.locale.to_s}"
	return ""
    end

    def license_icon_url(license_url,img_size="88x31")
	license_icon_url = license_url + img_size + ".png"
	return license_icon_url.gsub!("creativecommons.org/licenses","i.creativecommons.org/l")
    end
		
  end
end
