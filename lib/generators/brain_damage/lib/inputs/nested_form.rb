require 'erb'
require_relative 'base'

module BrainDamage
  module Inputs
    class NestedForm < Base
      def initialize(options)
        @template_file = 'nested_form.html.haml'
        super
      end

      def nested_plural_table_name
        name.to_s.pluralize
      end

      def nested_singular_table_name
        name.to_s.singularize
      end

      def nested_object_name
        nested_singular_table_name.capitalize
      end

      def nested_on
        field_description.relation.nested_on
      end
    end
  end
end
