require 'test_generator'

models = Dir[Rails.root.join('app/models/*.rb')].map do |filename|
  filename
    .gsub(Rails.root.join('app/models/').to_s, '')
    .gsub('.rb', '')
    .camelize
    .constantize
end

models.each do |model|
  model.connection
  model.include(TestGenerator::Observer)
  model.observe

  puts "Observer for #{model} initialized"
end
