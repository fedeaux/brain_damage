module BrainDamage
  module Inputs
    class Base
      attr_reader :options
      attr_reader :type
      attr_reader :field_description

      def initialize(options)
        @options = options
        @type = self.class.to_s.split('::').last.underscore.to_sym

        @field_description = options[:field_description]
        adjust_name
      end

      def html
        ERB.new(File.open("#{__dir__}/templates/#{@template_file}").read).result(binding)
      end

      def adjust_name
        return if @options[:name]

        if field_description.resource.fields[field_description.name] == :belongs_to
          @options[:name] = "#{field_description.name.to_s.gsub('_id', '')}_id"
        else
          @options[:name] = field_description.name
        end
      end

      def method_missing(method)
        @field_description.send method
      end

      class << self
        attr_accessor :template_file
      end
    end
  end
end
