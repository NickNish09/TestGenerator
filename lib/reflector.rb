module Reflect
  class Reflector
    def reflect(klass, method, attributes, args)
      if attributes.nil?
        @instance = Object.const_get(klass).new
      else
        @instance = Object.const_get(klass).new(attributes)
      end
      if Object.const_get(klass).respond_to?(method) # class method
        Object.const_get(klass).send(method, *args)
      else
        @instance.send(method, *args)
      end
    end
  end
end