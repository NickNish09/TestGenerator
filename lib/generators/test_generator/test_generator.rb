require 'test_generator'

module TestGenerator
  class InstallGenerator < Rails::Generators::Base
    desc "Creates a observer initializer file."
    def create_observer_initialize_file
      template_path = File.join(File.dirname(__FILE__), './templates/observer.rb')
      template = File.read(template_path)
      create_file "config/initializers/observer.rb", template

      puts "Observer Initializer created."
    end
  end
end