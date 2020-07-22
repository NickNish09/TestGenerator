require 'rails/generators/base'

module TestGenerator
  class InstallGenerator < Rails::Generators::Base
    desc "Creates a aspects initializer file."
    def create_aspect_initialize_file
      template = File.read('./templates/aspects.rb')
      create_file "config/initializers/aspects.rb", template

      puts "Aspects Initializer created."
    end
  end
end
