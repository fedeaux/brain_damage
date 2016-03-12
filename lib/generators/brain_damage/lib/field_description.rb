require_relative 'inputs/factory'
require_relative 'relation'

module BrainDamage
  class FieldDescription
    attr_reader :description
    attr_reader :input
    attr_reader :name
    attr_reader :relation
    attr_reader :resource
    attr_accessor :attribute
    attr_accessor :virtual

    def display
      @display.html
    end

    def initialize(name, description, resource)
      @name = name
      @description = description
      @resource = resource
      @type = description[:type]
      @virtual = description[:virtual]

      if description[:input]
        set_input description[:input][:type]
      end

      if description[:display]
        set_display description[:display][:type]

      else
        if virtual?
          set_display :unexistent
        else
          set_display :default
        end
      end

      if description[:relation]
        set_relation description[:relation]
      end

      if description[:type] == :internal
        set_input :hidden
      end
    end

    def virtual?
      @virtual
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

    def set_relation(description)
      description[:field_description] = self
      @relation = BrainDamage::Relation.new description
    end

    def add_to_model
      return nil unless @relation
      @relation.add_to_model
    end

    def method_missing(method)
      @resource.send method
    end
  end
end
