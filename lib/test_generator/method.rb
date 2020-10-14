module TestGenerator
  module Method
    include TestGenerator::Utils

    def method_specs(line)
      klass, method_name, args, attrs, response = destruct(line)

      "describe '##{method_name}' do
    it 'should' do
      expect(#{klass.downcase}.#{method_name}(#{args.join(', ')})).to eq #{response}
    end
  end"
    end
  end
end
