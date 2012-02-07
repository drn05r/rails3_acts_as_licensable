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

  def create_locale_files
    if File.exists? "config/initializers/locale.rb"
      f = File.open "config/initializers/locale.rb" 
      locale = f.read; f.close
      unless locale =~ /I18n.load_path \+= Dir\[Rails.root.join\('config', 'locale', '\*.{rb,yml}'\)\]/
        print "    \e[1m\e[34mquestion\e[0m  Your config/initializers/locale.rb requires an extra line to load locale files from 'config/locales/'. Is this okay? [y/n] "
        begin
          answer = gets.chomp
        end while not answer =~ /[yn]/i
        if answer =~ /y/i
          locale += "\nI18n.load_path += Dir[Rails.root.join('config', 'locale', '*.{rb,yml}')]"

          tmp_real_path = File.expand_path("tmp/~locale.rb")

          tmp = File.open tmp_real_path, "w"
          tmp.write locale; tmp.close

          remove_file 'config/initializers/locale.rb'
          copy_file tmp_real_path, 'config/initializers/locale.rb'
          remove_file tmp_real_path
        end
      else
        puts "    \e[1m\e[33mskipping\e[0m  config/initializers/locale.rb modification is already done."
      end
    else
      template 'locale.rb' 'config/initializers/locale.rb'
    end
    template 'en.yml', 'config/locales/rails3_acts_as_licensable.en.yml'
    template 'de.yml', 'config/locales/rails3_acts_as_licensable.de.yml'
  end

  def update_application_template
    f = File.open "app/views/layouts/application.html.erb"
    layout = f.read; f.close

    if layout =~ /<%=[ ]+yield[ ]+%>/
      print "    \e[1m\e[34mquestion\e[0m  Your layouts/application.html.erb layout currently has the line <%= yield %>. This gem needs to change this line to <%= content_for?(:content) ? yield(:content) : yield %> to support its nested layouts. This change should not affect any of your existing layouts or views. Is this okay? [y/n] "
      begin
        answer = gets.chomp
      end while not answer =~ /[yn]/i

      if answer =~ /y/i

        layout.gsub!(/<%=[ ]+yield[ ]+%>/, '<%= content_for?(:content) ? yield(:content) : yield %>')

        tmp_real_path = File.expand_path("tmp/~application.html.erb")

        tmp = File.open tmp_real_path, "w"
        tmp.write layout; tmp.close

        remove_file 'app/views/layouts/application.html.erb'
        copy_file tmp_real_path, 'app/views/layouts/application.html.erb'
        remove_file tmp_real_path
      end
    elsif layout =~ /<%=[ ]+content_for\?\(:content\) \? yield\(:content\) : yield[ ]+%>/
      puts "    \e[1m\e[33mskipping\e[0m  layouts/application.html.erb modification is already done."
    else
      puts "    \e[1m\e[31mconflict\e[0m  The gem is confused by your layouts/application.html.erb. It does not contain the default line <%= yield %>, you may need to make manual changes to get this gem's nested layouts working. Visit ###### for details."
    end

    f = File.open "app/assets/javascripts/application.js"
    appjs = f.read; f.close
    
    unless appjs =~ /=[ ]+require[ ]+tinymce/
      print "    \e[1m\e[34mquestion\e[0m  Your assets/javascripts/application.js currently does not have the line: //= require tinymce. This gem needs to add this line to support its Tiny MCE form textboxes. This change should not affect any of your existing forms. Is this okay? [y/n] "
      begin
        answer = gets.chomp
      end while not answer =~ /[yn]/i

      if answer =~ /y/i

        appjs += "\n//= require tinymce"

        tmp_real_path = File.expand_path("tmp/~application.js")

        tmp = File.open tmp_real_path, "w"
        tmp.write appjs; tmp.close

        remove_file 'app/assets/javascripts/application.js'
        copy_file tmp_real_path, 'app/assets/javascripts/application.js'
        remove_file tmp_real_path
      end
    else
      puts "    \e[1m\e[33mskipping\e[0m  assets/javascripts/application.js modification is already done."
    end

  end

end
