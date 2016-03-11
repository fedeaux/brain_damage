module BrainDamage
  class Relation
    attr_reader :type

    def initialize(description)
      @description = description
      @type = description[:type]
      @field_description = description[:field_description]
    end

    def add_to_model
      return [relation_line, accepts_nested_fields_for_line]
    end

    def relation_line
      case @type
        when :has_many
          line = ["has_many :#{name.to_s.gsub('_ids', '')}"]

          (line + (@description[:options] || {}).map { |name, value|
            "#{name}: :#{value}"
          }).join(', ')
        else
          nil
        end
    end

    def accepts_nested_fields_for_line
      if [:has_many, :has_one].include? @type and @field_description.input and @field_description.input.type == :nested_form
        "accepts_nested_fields_for :#{name}"
      else
        nil
      end
    end

    def method_missing(method)
      @field_description.send method
    end

    def nested_on
      @description[:options][:as]
    end
  end
end
