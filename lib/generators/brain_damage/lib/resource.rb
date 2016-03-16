require_relative 'field_description'
require_relative 'displays/factory'
require_relative 'views_manager'
require_relative 'virtual_field'
require_relative 'validations'

module BrainDamage
  class Resource
    attr_accessor :name
    attr_accessor :fields
    attr_accessor :generator
    attr_reader :views_manager
    attr_reader :virtual_fields
    attr_reader :validations

    def initialize(initializers)
      @plugins = {}
      @fields_descriptions = {}
      @virtual_fields = []

      self.fields = {}

      initializers.each do |initializer|
        if initializer.is_a? File
          instance_eval initializer.read, initializer.path
        end
      end
    end

    def set_validations(options)
      @validations = BrainDamage::Validations.new options
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
      description[:virtual] = !@fields.include?(name)

      @fields_descriptions[name] = BrainDamage::FieldDescription.new name, description, self

      if @fields_descriptions[name].virtual?
        @virtual_fields << BrainDamage::VirtualField.new(name, description)
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

    def display_attribute(attribute, args = {})
      name = attribute.name.to_sym

      unless @fields_descriptions[name]
        @fields_descriptions[name] = BrainDamage::FieldDescription.new name, {}, self
      end

      @fields_descriptions[name].attribute = attribute
      @fields_descriptions[name].display args
    end

    def virtual_fields_white_list
      @virtual_fields.map { |virtual_field|
        virtual_field.white_list
      }.reject(&:nil?)
    end

    def add_to_model(reorder_lines = [])
      to_add = reorder_lines
      if @validations
        to_add += @validations.add_to_model
      end

      prettify_model_lines (to_add + @fields_descriptions.values.map(&:add_to_model).flatten).reject(&:nil?)
    end

    def method_missing(method)
      @generator.send method
    end

    def self.method_added(method)
    end

    private
    def prettify_model_lines(lines)
      return [] unless lines.any?

      pairs = lines.map { |line|
        i = case line
            when /validates/
              0

            when /accepts/
              2

            else
              1
            end

        [ line, i]
      }.sort { |pair_a, pair_b|
        natural = pair_b[1] <=> pair_a[1]
        if natural != 0 then natural else pair_b[0] <=> pair_a[0] end

      }

      current_i = pairs.first[1]

      lines = []
      pairs.each do |pair|
        if pair[1] != current_i
          lines << "\n"
          current_i = pair[1]
        end

        lines << pair[0]
      end

      lines
    end
  end
end
