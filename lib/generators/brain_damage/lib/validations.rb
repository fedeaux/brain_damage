module BrainDamage
  class Validations
    attr_reader :validations

    def initialize(options)
      @validations = options[:validations]
    end

    def add_to_model
      @validations.map do |field, options|
        "validates :#{field}, #{options.inspect.gsub('=>', ' => ')}"
      end
    end
  end
end
