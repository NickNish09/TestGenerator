module TestGenerator
  module Factory
    include TestGenerator::Association
    include TestGenerator::Utils

    DENYLIST = ['id', 'created_at', 'updated_at', 'reset_password_token', 'reset_password_sent_at', 'remember_created_at', 'discarded_at']
    
    REPLACE_LIST = ['encrypted_password']

    REPLACE_TABLE = {
      "encrypted_password" => "password"
    }

    def example(column_name, column_type)
      if column_name == 'email'
        return "SecureRandom.uuid + '@example.com'"
      end

      case column_type
      when :string
        "SecureRandom.uuid"
      when :integer
        1
      when :float
        3.14
      when :datetime
        "'#{DateTime.now}'"
      when :time
        "'#{Time.now}'"
      when :date
        "'#{Date.today}'"
      when :boolean
        true
      end
    end

    def factory_exists?(klass)
      Dir[Rails.root.join('spec/factories/*.rb')].map { |filename| filename.gsub(Rails.root.join('spec/factories/').to_s, "").gsub('.rb', '') }.include?(klass.table_name)
    end

    def factories
      get_models.map { |model| factory(model, associations(model)) unless factory_exists?(model) }.compact
    end

    def factory(klass, associations)
      attrs = {}
      factory_attrs = []

      klass.columns_hash.each do |k, v|
        k = REPLACE_TABLE[k] if REPLACE_LIST.include?(k)

        attrs[k] = v.type unless DENYLIST.include?(k) or k.include?('id')
      end

      # verificar arquivo temporario a procura de atributos reais, se não, completa com exemplo

      attrs.each do |attr, column_type|
        factory_attrs << "#{attr} { #{example(attr, column_type)} }"
      end

      if associations.keys.include?('belong_to')
        associations["belong_to"].each do |association|
          factory_attrs << association.to_s
        end
      end

      return [klass.table_name, klass.table_name.singularize, factory_attrs]
    end
  end
end
