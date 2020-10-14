module TestGenerator
  module Method
    include TestGenerator::Utils

    def method_specs(line)
      denylist = ["updated_at", "created_at", "id"]
      klass, method_name, args, attrs, response = destruct(line)

      attrs_string = "{ "
      attrs.keys.each do |key|
        unless denylist.include?(key)
          unless(/(.*)_id$/.match?(key)) # if it is an association, ignore
            attrs_string.concat("#{key}: '#{attrs[key]}', ")
          end
        end
      end
      final_attrs = attrs_string.reverse.sub(',', '} ').reverse

      "describe '##{method_name}' do
    it 'should' do
      #{klass.downcase} = create(:#{klass.downcase}, #{final_attrs})
      expect(#{klass.downcase}.#{method_name}(#{args.join(', ')})).to eq #{response}
    end
  end"
    end
  end
end
