require_relative 'inputs/factory'

module BrainDamage
  class FieldDescription
    attr_reader :name
    attr_reader :description
    attr_reader :input
    attr_reader :resource
    attr_accessor :attribute

    def display
      @display.html
    end

    def initialize(name, description, resource)
      @name = name
      @description = description
      @resource = resource
      @type = description[:type]

      if description[:input]
        set_input description[:input][:type]
      end

      if description[:display]
        set_display description[:display][:type]
      else
        set_display :default
      end

      if description[:type] == :internal
        set_input :hidden
      end
    end

    def set_input(type)
      @description[:input] ||= {}
      @description[:input][:options] ||= {}
      @description[:input][:options][:field_description] = self
      @input = BrainDamage::Inputs::Factory.make type, @description[:input][:options]
    end

    def set_display(type)
      @description[:display] ||= {}
      @description[:display][:options] ||= {}
      @description[:display][:options][:field_description] = self
      @display = BrainDamage::Displays::Factory.make type, @description[:display][:options]
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

    def method_missing(method)
      @resource.send method
    end
  end
end
