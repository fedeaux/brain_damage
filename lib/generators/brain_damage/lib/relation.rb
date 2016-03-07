module BrainDamage
  class Relation
    attr_reader :type

    def initialize(description)
      @description = description
      @type = description[:type]
      @field_description = description[:field_description]
    end

    def add_to_model
      return case @type
        when :has_many
          line = ["has_many :#{name.to_s.gsub('_ids', '')}"]

          (line + (@description[:options] || {}).map { |name, value|
            "#{name}: :#{value}"
          }).join(', ')
        else
          nil
        end
    end

    def method_missing(method)
      @field_description.send method
    end
  end
end
