require 'aquarium'
include Aquarium::Aspects

# Load Rails constants
Rails.application.eager_load!

# Get Rails models and controllers classes
controllers = ApplicationController.subclasses
models = ApplicationRecord.subclasses

puts "Aspects initialized"

Aspect.new(:around,
           calls_to: :all_methods,
           for_types: models + controllers,
           method_options: [:exclude_ancestor_methods, :class]) do |jp, obj, *args|
  begin
    # Get class
    klass = jp.target_type.name.constantize
    # puts klass

    # List all klass public instance methods
    if models.include? klass
      public_instance_methods = (klass.public_instance_methods - Object.public_instance_methods).sort
      # puts public_instance_methods
    end

    # Get method
    method = jp.method_name.to_sym
    # puts method

    # Get object current state
    if models.include? klass
      if obj.class == Class
      else
        current_state = obj.attributes
      end
      # puts current_state
    end

    # Create temp file
    file_name ="#{Rails.root}/tmp/#{klass.to_s}.rb"

    file = File.new(file_name, 'a')

    str = "{ \"klass\": \"#{klass}\", \"method\": \"#{method}\", \"args\": #{args.inspect}, \"current_state\": #{current_state.to_json} }"

    unless File.open(file_name).each_line.any? { |line| line.include?(str)}
      file.puts str
    end

    jp.proceed
  ensure
    if file
      file.close
    end
  end
end
