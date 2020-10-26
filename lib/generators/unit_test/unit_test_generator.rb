require 'test_generator'

class UnitTestGenerator < Rails::Generators::NamedBase
  include TestGenerator::TempReader
  include TestGenerator::Association
  include TestGenerator::Validation
  include TestGenerator::Subject
  include TestGenerator::Method

  source_root File.expand_path("../../templates", __FILE__)

  desc "Creates validations, associations and methods specs"

  def create_unit_test
    @klass = class_name

    lines = read_temp_file(@klass)

    @methods_specs = []
    @validations_specs = []
    @associations_specs = []

    # Generate association specs
    associations = associations(@klass.camelize.constantize)

    associations.each do |kind, names|
      @associations_specs << association_specs(kind, names)
    end
    
    @associations_specs = @associations_specs.flatten.uniq.compact

    # Generate validation specs
    validations = validations(@klass.camelize.constantize)

    validations.each do |kind, attrs|
      @validations_specs << validation_specs(kind, attrs)
    end

    @validations_specs = @validations_specs.flatten.uniq.compact

    # Generate subject for model
    @subject_spec = subject(@klass)

    # Generate methods specs
    lines.each do |line|
      @methods_specs << method_specs(line)
    end

    template "model_spec.rb", Rails.root.join("spec/models/#{class_name.tableize.singularize}_spec.rb")
  end
end