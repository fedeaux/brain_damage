require_relative '../templateable/base'

module BrainDamage
  module Inputs
    class Base < Templateable::Base
      attr_reader :type

      def initialize(options)
        super
        @type = self.class.to_s.split('::').last.underscore.to_sym
        adjust_name
      end

      def adjust_name
        return if @options[:name]

        if field_description.resource.fields[field_description.name] == :belongs_to
          @options[:name] = "#{field_description.name.to_s.gsub('_id', '')}_id"
        else
          @options[:name] = field_description.name
        end
      end

      def field_type
        attribute.field_type
      end

      def dir
        __dir__
      end
    end
  end
end
