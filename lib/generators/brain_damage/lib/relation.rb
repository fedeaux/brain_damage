module BrainDamage
  class Relation
    def initialize(description)
      @description = description
      @type = description[:type]
    end

    def add_to_model
      return case @type
        when :has_many
          line = ["has_many :#{@name.to_s.gsub('_ids', '')}"]

          (line + (@description[:type_options] || {}).map { |name, value|
            "#{name}: :#{value}"
          }).join(', ')
        else
          nil
        end
    end
  end
end
