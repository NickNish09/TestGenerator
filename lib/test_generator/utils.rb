module TestGenerator
  module Utils
    def destruct(line)
      [line['klass'], line['method'], line['args'], line['attrs'], line['response']]
    end
  end
end
