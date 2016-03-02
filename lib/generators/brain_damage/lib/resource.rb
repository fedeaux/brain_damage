module BrainDamage
  class Resource
    attr_accessor :name
    attr_accessor :fields
    attr_accessor :view_schema

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
      @inputs[name] = parameters
    end
  end
end
