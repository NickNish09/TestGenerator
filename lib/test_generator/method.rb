module TestGenerator
  module Method
    include TestGenerator::Utils
    include TestGenerator::Reflector

    def method_specs(line)
      klass, method_name, args, attrs = destruct(line)

      DatabaseCleaner.clean_with(:truncation)
      DatabaseCleaner.start
      DatabaseCleaner.clean

      obj = FactoryBot.create(klass.tableize.singularize.to_sym)
      
      response = reflect(klass, method_name, args, obj)

      "it '##{method_name}' do\n\t\texpect(subject.#{method_name}(#{args.join(', ')})).to eq(#{response})\n\tend"
    end
  end
end