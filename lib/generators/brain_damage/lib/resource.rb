require_relative 'inputs/factory'
require_relative 'views_manager'

module BrainDamage
  class Resource
    attr_accessor :name
    attr_accessor :fields
    attr_reader :views_manager

    def initialize(args)
      @plugins = {}
      @inputs = {}
      self.fields = {}

      if args.is_a? File
        instance_eval args.read
      end
    end

    def as_cmd_parameters
      [name] + fields_as_parameters
    end

    def include_attribute_on_form
    end

    def fields_as_parameters
      @fields.map { |name, type| field_as_parameter name, type }
    end

    def field_as_parameter(name, type)
      "#{name.to_s}:#{type.to_s}"
    end

    def add_plugin(name, parameters)
      @plugins[name] = parameters
    end

    def specify_input(name, parameters)
      parameters[:options] ||= {}
      parameters[:options][:name] = name
      @inputs[name] = BrainDamage::Inputs::Factory.make parameters[:type], parameters[:options]
    end

    def input_specified?(attribute)
      @inputs.has_key? attribute.name.to_sym
    end

    def input_for(attribute)
      input = @inputs[attribute.name.to_sym]
      input.attribute = attribute
      input
    end

    def set_view_schema(args)
      @views_manager = BrainDamage::ViewsManager.new args
    end
  end
end
