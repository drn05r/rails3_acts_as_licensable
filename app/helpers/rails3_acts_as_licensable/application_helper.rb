module Rails3ActsAsLicensable
  module ApplicationHelper

    def strip_html(str, preserve_tags=[])
      str = str.strip || ''
      preserve_arr = preserve_tags.join('|') << '|\/'
      str.gsub(/<(\/|\s)*[^(#{preserve_arr})][^>]*>/,'')
    end

    def license_url_locale
	unless I18n.locale.to_s == "en"
            return I18n.locale.to_s+"/"
        end
	return ""
    end
  end
end
