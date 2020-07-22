$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "test_generator"
  s.version     = "1.0"
  s.platform    = "ruby"
  s.authors     = ["Nicholas Marques", "Rafael Fernandes"]
  s.email       = ["nnmarques97@gmail.com"]
  s.homepage    = "https://github.com/NickNish09/TestGenerator"
  s.summary     = %q{Auto generate tests based on system usage and BDD.}
  s.description = %q{This gem will track everything users do in the system and map it into controllers and model methods beeing called, and generate tests for them}
  s.files = Dir.glob("{lib}/**/*")
  s.require_path = 'lib'
  s.add_development_dependency 'rails', '>= 3.2.0'
  s.add_development_dependency 'cucumber-rails', '>= 0'
  s.add_development_dependency 'rspec-rails', '>= 0'
  s.add_development_dependency 'aquarium', '>= 0'
end