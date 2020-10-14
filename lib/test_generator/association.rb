module TestGenerator
  module Association
    def reflection_by_class(klass)
      case klass
      when "ActiveRecord::Reflection::HasAndBelongsToManyReflection"
        'have_and_belong_to_many'
      when "ActiveRecord::Reflection::HasManyReflection"
        'have_many'
      when "ActiveRecord::Reflection::BelongsToReflection"
        'belong_to'
      when "ActiveRecord::Reflection::HasOneReflection"
        'have_one'
      end
    end

    def associations(klass)
      formatted = klass.reflect_on_all_associations.map do |reflection|
        { kind: reflection_by_class(reflection.class.to_s), name: reflection.name }
      end

      formatted = formatted.inject(Hash.new([])) { |h, a| h[a[:kind]] += [a[:name]]; h }
    end

    def association_specs(kind, names)
      names.map { |name| "it { should #{kind}(:#{name}) }" }
    end
  end
end
