module BrainDamage
  class Relation
    attr_reader :type

    def initialize(description)
      @description = description
      @type = description[:type]
      @field_description = description[:field_description]
    end

    def add_to_model
      return [relation_line, accepts_nested_attributes_for_line]
    end

    def relation_line
      line = nil

      case @type
        when :has_many
          line = ["has_many :#{name.to_s.gsub('_ids', '')}"]
        when :has_one
          line = ["has_one :#{name.to_s.gsub('_id', '')}"]
      end

      if line
        return(line + (@description[:options] || {}).map { |name, value|
           "#{name}: :#{value}"
         }).join(', ')
      end
    end

    def accepts_nested_attributes_for_line
      if [:has_many, :has_one].include? @type and @field_description.input and @field_description.input.type == :nested_form
        "accepts_nested_attributes_for :#{name}"
      else
        nil
      end
    end

    def method_missing(method)
      @field_description.send method
    end

    def resource_name_according_to_foreign
      @description[:options][:as] or singular_table_name
    end

    def nested_on
      resource_name_according_to_foreign
    end
  end
end
