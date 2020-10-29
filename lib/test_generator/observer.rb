module TestGenerator
  module Observer
    DENYLIST = [:attributes, :serializable_hash, :inspect]

    include TestGenerator::Logger
    
    def self.included(base_klass)
      base_klass.extend(ClassMethods)
      observer = const_set("#{base_klass.name}Observer", Module.new)
      base_klass.prepend observer
    end

    module ClassMethods
      def observe
        klass = self
        methods = klass.instance_methods(false) - DENYLIST
        observer = const_get "#{klass.name}Observer"
        
        observer.class_eval do
          methods.each do |method_name|
            define_method(method_name) do |*args, &block|
              log(klass, method_name, args, self)
              super(*args, &block)
            end
          end
        end
      end
    end
  end
end
