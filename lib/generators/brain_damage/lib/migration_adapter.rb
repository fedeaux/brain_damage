module BrainDamage
  class MigrationAdapter
    def initialize(resource)
      @resource = resource
    end

    def adapt_model_lines(lines)
      @lines = lines

      adapt_belongs_to_lines

      @lines
    end

    def adapt_belongs_to_lines
      @lines
    end
  end
end
