module TestGenerator
  module Subject
    def subject(klass)
      "subject { create(:#{klass.tableize.singularize}) }"
    end
  end
end
