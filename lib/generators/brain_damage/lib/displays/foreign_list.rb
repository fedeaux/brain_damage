require 'erb'
require_relative 'base'

module BrainDamage
  module Displays
    class ForeignList < Base
      attr_reader :deletable
      attr_reader :editable

      def initialize(options)
        @template_file = 'foreign_list.html.haml'
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
