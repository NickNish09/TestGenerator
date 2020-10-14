module TestGenerator
  module TempReader
    def read_temp_file(klass)
      file_path = Rails.root.join("tmp/#{klass}.rb")

      return false unless File.exists?(file_path)

      File.readlines(file_path).map { |line| JSON.parse(line.strip) }
    end
  end
end
