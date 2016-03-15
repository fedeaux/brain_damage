require 'erb'
require_relative 'base'

module BrainDamage
  module Displays
    class InnerInlineEdit < Base
      def initialize(options)
        super

        inner_display_type = @options[:display][:type]
        inner_display_options = @options.merge @options[:display][:options]

        @inner_display = Factory.make inner_display_type, inner_display_options
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
