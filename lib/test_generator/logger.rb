module TestGenerator
  module Logger
    def log(klass, method_name, args, attrs, response)
      # Create temp model file
      file_name = Rails.root.join("tmp/#{klass}.rb")
      file_line = "{ \"klass\": \"#{klass}\", \"method\": \"#{method_name}\", \"args\": #{args.inspect}, \"attrs\": #{attrs.to_json}, \"response\": #{response.inspect.gsub('nil', 'null').to_json} }"

      file = File.new(file_name, 'a')
      
      unless File.open(file_name).each_line.any? { |line| line.include?(file_line) }
        file.puts file_line
      end

      file.close
    end
  end
end
