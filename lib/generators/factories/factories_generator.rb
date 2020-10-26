require 'test_generator'

class FactoriesGenerator < Rails::Generators::NamedBase
  include TestGenerator::Factory

  source_root File.expand_path("../../templates", __FILE__)

  desc "Creates factory file to each model"

  def create_factories
    factories = factories()

    factories.each do |factory|
      @factory_name = factory[1]
      @factory_attrs = factory[2]

      template "model_factory.rb", Rails.root.join("spec/factories/#{factory[0]}.rb")
    end
  end
end
