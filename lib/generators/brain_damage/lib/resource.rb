module BrainDamage
  class Resource
    attr_accessor :name
    attr_accessor :fields
    attr_accessor :view_schema

    def initialize(args)
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
  end
end
