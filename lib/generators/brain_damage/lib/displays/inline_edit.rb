require 'erb'
require_relative 'base'

module BrainDamage
  module Displays
    class InlineEdit < Base
      def initialize(options)
        super

        @auxiliar_file_name = "inline_edit/_#{name}"
        @inner_inline_edit = Factory.make :inner_inline_edit, @options

        field_description.resource.views_manager.add_special_view 'inline_edit'
      end

      def html(args = {})
        field_description.resource.views_manager.add_dynamic_view @auxiliar_file_name, @inner_inline_edit.html

        super
      end

      def inner_display(args = {})
        @inner_display.html args
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
