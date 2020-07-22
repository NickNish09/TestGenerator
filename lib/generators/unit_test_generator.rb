class UnitTestGenerator < Rails::Generators::Base
  def create_unit_tests
    require 'json'
    require 'reflector'
    class_name = args[0]
    file_name = class_name.downcase
    puts "criando testes unitarios para #{class_name}..."
    is_controller = /.*Controller$/.match?(class_name)
    class_type = "model"
    first_line = File.open("#{Rails.root}/tmp/#{class_name}.rb", &:readline)
    sample_object = JSON.parse(first_line)["current_state"]

    executed_methods = []
    executed_arguments = {}
    if is_controller
      class_type = "controller"
      template = %Q{require 'rails_helper'

RSpec.describe #{class_name}, :type => :#{class_type} do
}
      File.readlines("#{Rails.root}/tmp/#{class_name}.rb").each do |line|
        json_string = JSON.parse(line.strip)
        puts "\nReflecting..."
        reflector = Reflect::Reflector.new
        klass = json_string["klass"]
        meth = json_string["method"]
        cs = json_string["current_state"]
        args = json_string["args"]
        class_and_method_name = "#{klass}::#{meth}"
        if executed_methods.include?(class_and_method_name)
          if executed_arguments[class_and_method_name.to_sym].include?(args)
            # do nothing, same test
          else
            # same test with other arguments
            executed_arguments[class_and_method_name.to_sym].push(args)
          end
        else # other test for other method
          executed_methods.push(class_and_method_name)
          executed_arguments[class_and_method_name.to_sym] = []
          puts "Executando #{klass}::#{meth} com argumentos #{args} no objeto #{sample_object}"
          reflection = reflector.reflect(klass, meth, sample_object, args)
          puts "Resultado: #{reflection}"
          print "\n"

          template_aux = %Q{
  describe 'GET #{meth}' do
    it 'returns a successful response' do
      get :#{meth}
      expect(response).to be_successful
    end

    it 'renders the #{meth} template' do
      get :#{meth}
      expect(response).to render_template("#{meth}")
    end
  end
      }
          template.concat(template_aux)
        end
      end

      template.concat(%Q{
end
                    })
    else
      template = %Q{require 'rails_helper'

RSpec.describe #{class_name}, :type => :#{class_type} do
  let(:#{file_name}) { #{class_name}.new(#{sample_object}) }

  it "is valid with valid attributes" do
    expect(#{file_name}).to be_valid
  end
}
      File.readlines("#{Rails.root}/tmp/#{class_name}.rb").each do |line|
        json_string = JSON.parse(line.strip)
        puts "\nReflecting..."
        reflector = Reflect::Reflector.new
        klass = json_string["klass"]
        meth = json_string["method"]
        cs = json_string["current_state"]
        args = json_string["args"]
        class_and_method_name = "#{klass}::#{meth}"
        if executed_methods.include?(class_and_method_name)
          if executed_arguments[class_and_method_name.to_sym].include?(args)
            # do nothing, same test
          else
            # same test with other arguments
            executed_arguments[class_and_method_name.to_sym].push(args)
          end
        else # other test for other method
          executed_methods.push(class_and_method_name)
          executed_arguments[class_and_method_name.to_sym] = []
          puts "Executando #{klass}::#{meth} com argumentos #{args} no objeto #{sample_object}"
          reflection = reflector.reflect(klass, meth, sample_object, args)
          puts "Resultado: #{reflection}"
          print "\n"

          template_aux = %Q{
  describe '##{meth}' do
    it "should return valid string for method #{meth}" do
      expect(#{class_name.downcase}.#{meth}(#{args.join(', ')})).to eq "#{reflection}"
    end
  end
      }
          template.concat(template_aux)
        end
      end

      template.concat(%Q{
end
                    })
    end

    create_file "spec/#{class_type}s/#{file_name.sub('controller', '_controller')}_spec.rb", template

    puts "Testes criados."
  end
end