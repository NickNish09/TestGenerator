require 'test_generator'

module TestGenerator
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../../templates", __FILE__)

    desc "Creates a observer initializer file"

    def copy_initializer
      template "observer.rb", "config/initializers/observer.rb"
    end
  end
end
