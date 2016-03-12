require 'erb'
require_relative 'base'

module BrainDamage
  module Displays
    class ForeignInline < Base
      attr_reader :deletable
      attr_reader :editable

      def initialize(options)
        @template_file = 'foreign_inline.html.haml'

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
    end
  end
end
