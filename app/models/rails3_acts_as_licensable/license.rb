require "rdf_on_rails"

module Rails3ActsAsLicensable
  class License < ActiveRecord::Base
    def self.unique_name_for_default
      "cc0_1_0"
    end
    
    def self.default
      @@default ||= find_by_unique_name(unique_name_for_default)
    end
    
    def self.default_id
      default.id
    end
    
    attr_accessible :unique_name, :url

    validates_presence_of :unique_name, :url
    validates_uniqueness_of :unique_name, :url
  
    has_many :license_attributes, 
             :class_name => "Rails3ActsAsLicensable::LicenseAttribute", 
             :inverse_of => :license,
             :dependent => :destroy
             
    has_many :license_options,
             :class_name => "Rails3ActsAsLicensable::LicenseOption",
             :through => :license_attributes,
             :source => :license_option,
             :readonly => true
    
    has_many :licensings, 
             :class_name => "Rails3ActsAsLicensable::Licensing",
             :inverse_of => :license,
             :dependent => :destroy
             
    default_scope order(arel_table[:unique_name])
    
    def title
      I18n.t("licenses.#{read_attribute(:unique_name)}.title")
    end
    
    def description
      I18n.t("licenses.#{read_attribute(:unique_name)}.description")
    end

    def url_with_locale
      "#{url}#{url_locale}"
    end

    def url_locale
     "deed.#{I18n.locale}"
    end

    def icon_url(size = Rails3ActsAsLicensable::LicensesController.license_icon_size)
      url = read_attribute(:url).to_s.strip
      return nil if url.blank?
      "#{url}#{url.match(/\/$/) ? "" : "/"}#{size}.png".gsub("creativecommons.org/licenses", "i.creativecommons.org/l")
    end
    
    acts_as_rdf

    def to_rdf_uri(options = nil)
      if attribute_present?(:url)
        RDF::URI.new(read_attribute(:url))
      else
        nil
      end
    end

    def to_rdf_graph!(graph, uri_options = nil, options = nil)
      current_user = (options[:current_user] rescue nil)

      if context = graph.context
        [RDF::CC.send(:License), RDF::OWL.send(:Thing)].each do |type|
          graph << [context, RDF.type, type]
        end

        graph << [context, RDF::DC.identifier, RDF::Literal.new(read_attribute(:unique_name), :datatype => RDF::XSD.string)]
        graph << [context, RDF::DC.title, RDF::Literal.new(self.title, :datatype => RDF::XSD.string, :language => I18n.locale.to_s)]
        graph << [context, RDF::DC.description, RDF::Literal.new(self.description, :datatype => RDF::XSD.string, :language => I18n.locale.to_s)]

        self.license_attributes.each do |license_attribute|
          graph << [context, RDF::CC.send(license_attribute.predicate.to_sym), RDF::URI.new(license_attribute.uri)]
        end
      end

      # done!
    end
  end
end
