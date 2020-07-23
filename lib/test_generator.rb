require 'rails/generators'

module TestGenerator
  class InstallGenerator < Rails::Generators::Base
    desc "Creates a aspects initializer file."
    def create_aspect_initialize_file
      template_path = File.join(File.dirname(__FILE__), './templates/aspects.rb')
      template = File.read(template_path)
      create_file "config/initializers/aspects.rb", template

      puts "Aspects Initializer created."
    end
  end
end
