require 'rails/generators'
require 'rails/generators/migration'

class Rails3ActsAsLicensableGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  
  def self.source_root
    @source_root ||= File.join(File.dirname(__FILE__), 'templates')
  end

  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      timestamp=Time.new.utc.strftime("%Y%m%d%H%M%S")
      if timestamp.to_i <= current_migration_number(dirname)
        (current_migration_number(dirname) + 1).to_s
      else
	      timestamp
      end
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end

  def create_migration_files
    migration_template 'migration_licenses.rb', 'db/migrate/create_rails3_acts_as_licensable_licenses_table.rb'
    migration_template 'migration_license_options.rb', 'db/migrate/create_rails3_acts_as_licensable_license_options_table.rb'
    migration_template 'migration_license_attributes.rb', 'db/migrate/create_rails3_acts_as_licensable_license_attributes_table.rb'
    migration_template 'migration_add_licenses.rb', 'db/migrate/add_rails3_acts_as_licensable_licenses.rb'
    migration_template 'migration_licensings.rb', 'db/migrate/create_rails3_acts_as_licensable_licensings_table.rb'
  end

  def create_config_files
    template 'config.yml', 'config/rails3_acts_as_licensable.yml'
  end
  
  def create_initializer_file
    template 'rails3_acts_as_licensable_helper.rb', 'config/initializers/rails3_acts_as_licensable_helper.rb'
  end

  def create_locale_files
    template 'en.yml', 'config/locales/rails3_acts_as_licensable.en.yml'
    template 'de.yml', 'config/locales/rails3_acts_as_licensable.de.yml'
  end

end
