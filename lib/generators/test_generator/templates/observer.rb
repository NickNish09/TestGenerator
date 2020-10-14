require 'test_generator'
Rails.application.eager_load!
ApplicationRecord.descendants.each do |model|
  model.send(:include, TestGenerator::Observer)
  model.observe
end