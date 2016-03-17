require_relative 'field_description'
require_relative 'displays/factory'
require_relative 'views_manager'
require_relative 'virtual_field'
require_relative 'validations'
require_relative 'model_adapter'
require_relative 'migration_adapter'

module BrainDamage
  class Resource
    attr_accessor :generator
    attr_accessor :fields
    attr_reader :name
    attr_reader :views_manager
    attr_reader :virtual_fields
    attr_reader :validations
    attr_reader :fields_descriptions

    def initialize(initializers)
      @plugins = []
      @fields_descriptions = {}
      @virtual_fields = []

      self.fields = {}

      initializers.each do |initializer|
        if initializer.is_a? File
          instance_eval initializer.read, initializer.path
        end
      end
    end

    def set_fields(fields_hash)
      @fields = {}

      fields_hash.each { |name, options|
        if options.is_a? Symbol
          options = { type: options }
        end

        @fields[name] = options
      }
    end

    def set_name(name)
      @name = name
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
      @fields.map { |name, options| field_as_parameter name, options }
    end

    def field_as_parameter(name, options)
      "#{name.to_s}:#{options[:type].to_s}"
    end

    def add_plugin(name, parameters)
      @plugins << BrainDamage::Plugins::Factory.make(name, parameters)
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

    def improve_model_code(model_code)
      ModelAdapter.improve_model_code self, model_code
    end

    def improve_migration_code(migration_code)
      MigrationAdapter.improve_migration_code self, migration_code
    end

    def method_missing(method)
      @generator.send method
    end

    def migration_file_full_path
      Dir["db/migrate/*"].select { |file_name|
        file_name.split('/').last =~ /\d+_create_#{name.underscore.pluralize}.rb/
      }.first
    end

    def ignore_migration?
      migration_file_exists?
    end

    def migration_file_exists?
      file_name = migration_file_full_path
      file_name && File.exists?(file_name)
    end
  end
end
