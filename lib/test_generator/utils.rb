module TestGenerator
  module Utils
    def destruct(line)
      [line['klass'], line['method'], line['args'], line['attrs']]
    end

    def get_models
      Dir[Rails.root.join('app/models/*.rb')]
        .map { |filename|
          filename
            .gsub(Rails.root.join('app/models/').to_s, '')
            .gsub('.rb', '')
        }
        .filter { |filename| 
          filename != 'application_record' 
        }.map { |filename| 
          filename
            .camelize
            .constantize
        }
    end
  end
end
