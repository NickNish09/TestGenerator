require 'rails/generators/base'
class EquivalenceClassGenerator < Rails::Generators::Base
  def create_equivalence_class_tests
    require 'json'
    require 'reflector'
    class_name = args[0]
    file_name = class_name.downcase
    puts "criando testes unitarios para #{class_name}..."
    is_controller = /.*Controller$/.match?(class_name)
    class_type = "model"

    template = %Q{require 'rails_helper'

RSpec.describe #{class_name}, :type => :#{class_type} do
}
    equivalence_class_counter = {}
    File.readlines("#{Rails.root}/tmp/#{class_name}.rb").each do |line|
      json_string = JSON.parse(line.strip)
      puts "\nReflecting..."
      reflector = Reflect::Reflector.new
      klass = json_string["klass"]
      meth = json_string["method"]
      cs = json_string["current_state"]
      args = json_string["args"]
      class_and_method_name = "#{klass}::#{meth}"

      equivalence_class_counter[meth] ||= {}
      args.each do |arg|
        String::CUSTOM_METHODS.each do |equivalence_class_method|
          respond_to_eq_class = arg.send(equivalence_class_method) # testa pra ver se responde à alguma classe de equivalencia
          if respond_to_eq_class # se responder à classe, adiciona 1 ao contador daquela classe
            if equivalence_class_counter[meth][equivalence_class_method].nil?
              equivalence_class_counter[meth][equivalence_class_method] = 1
            else
              equivalence_class_counter[meth][equivalence_class_method] += 1
            end
          end
        end
      end

    end

    equivalence_class_counter.each do |method,stats| # pega o hash com os métodos e as estatísticas de cada
      probabily_class =  stats.max_by{|k,v| v}
      template_aux = %Q{
  describe '##{method}_equivalence_class' do
    # #{probabily_class.last} entries with this class
    it "arguments should belong to #{String::EQUIVALENCE_CLASSES[probabily_class.first]} equivalence class" do
      expect(#{class_name.capitalize}).to receive(:#{method}).with("#{String::STRINGS_EQUIVALENCE_CLASSES[probabily_class.first]}")
      User.find_by_email_address("#{String::STRINGS_EQUIVALENCE_CLASSES[probabily_class.first]}")
    end
  end
      }
      template.concat(template_aux)
    end
    puts equivalence_class_counter

    template.concat(%Q{
end
                    })

    create_file "spec/#{class_type}s/#{file_name}_equiv_spec.rb", template
  end
end