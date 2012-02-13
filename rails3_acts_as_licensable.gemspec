# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
require File.expand_path("../lib/rails3_acts_as_licensable/version", __FILE__)

Gem::Specification.new do |s|
  s.name = "rails3_acts_as_licensable"
  s.version =  Rails3ActsAsLicensable::VERSION.to_s
  s.platform = Gem::Platform::RUBY
  s.authors = [ "David Newman" ]
  s.email = [ "drn@ecs.soton.ac.uk" ]
  s.description = "This is a Rails 3 engine that allows assets to have licenses (that the user can define) applied to them."
  s.summary = "rails3_acts_acs_licensable-#{s.version}"
  s.files = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.rdoc"]
# s.rubyforge_project = "blog3-rails3"
  s.add_dependency "activesupport" , "~> 3.1.1"
  s.add_dependency "rails"         , "~> 3.1.1"
  s.required_rubygems_version = "> 1.3.6"
  s.require_path = 'lib'
end
