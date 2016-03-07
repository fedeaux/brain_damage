require_relative 'field_description'
require_relative 'displays/factory'
require_relative 'views_manager'
require_relative 'virtual_field'

module BrainDamage
  class Resource
    attr_accessor :name
    attr_accessor :fields
    attr_accessor :generator
    attr_reader :views_manager
    attr_reader :virtual_fields

    def initialize(args)
      @plugins = {}
      @fields_descriptions = {}
      @virtual_fields = {
        array: []
      }

      self.fields = {}

      if args.is_a? File
        instance_eval args.read, args.path
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

    def describe_field(name, description)
      description[:options] ||= {}
      description[:options][:name] = name

      @fields_descriptions[name] = BrainDamage::FieldDescription.new name, description, self

      unless @fields.include? name
        @virtual_fields[:array] << name
      end
    end

    def field_described?(attribute)
      @fields_descriptions.has_key? attribute.name.to_sym
    end

    def field_description(attribute)
      description = @fields_descriptions[attribute.name.to_sym]

      return nil unless description

      description.attribute = attribute
      description
    end

    def set_view_schema(args)
      @views_manager = BrainDamage::ViewsManager.new args
    end

    def display_attribute(attribute)
      name = attribute.name.to_sym
      unless @fields_descriptions[name]
        @fields_descriptions[name] = BrainDamage::FieldDescription.new name, {}, self
      end

      @fields_descriptions[name].attribute = attribute
      @fields_descriptions[name].display
    end

    def virtual_fields_white_list
      @virtual_fields[:array].map { |field|
        @fields_descriptions[field].input
      }.reject(&:nil?).map { |input|
        ":#{input.options[:name]} => []"
      }
    end

    def virtual_fields_objects
      @virtual_fields[:array].map { |name|
        BrainDamage::VirtualField.new name
      }
    end

    def add_to_model
      @fields_descriptions.values.map(&:add_to_model).reject(&:nil?)
    end

    def method_missing(method)
      @generator.send method
    end
  end
end
