require 'rails/generators'

module Yelpster
  class ConfigGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    desc "This generator creates an initializer file at config/initializers, " +
         "with the default configuration options for Yelpster."
    def add_initializer
      template "initializer.rb", "config/initializers/yelpster.rb"
    end
  end
end
