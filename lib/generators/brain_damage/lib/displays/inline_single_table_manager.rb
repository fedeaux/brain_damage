require 'erb'
require_relative 'base'

module BrainDamage
  module Displays
    class InlineSingleTableManager < Base
      attr_reader :deletable
      attr_reader :editable

      def initialize(options)
        @deletable = options[:deletable] || false
        @editable = options[:editable] || false

        super
      end

      def foreign_plural_table_name
        field_description.name.to_s.pluralize
      end

      def foreign_singular_table_name
        field_description.name.to_s.singularize
      end

      def foreign_model_name
        foreign_singular_table_name.camelcase
      end

      def resource_name_according_to_foreign
        if field_description.relation
          field_description.relation.resource_name_according_to_foreign
        else
          singular_table_name
        end
      end
    end
  end
end
