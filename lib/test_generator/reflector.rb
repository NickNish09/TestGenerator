module TestGenerator
  module Reflector
    def reflect(klass, method_name, args, obj)
      attrs = obj.instance_variable_get("@attributes").to_hash

      # if klass.exists? id: attrs['id']
        # obj = klass.find(attrs['id'])

        response = if args.any?
          obj.method(method_name).super_method.call(args)
        else
          obj.method(method_name).super_method.call
        end
      # end
    end
  end
end
