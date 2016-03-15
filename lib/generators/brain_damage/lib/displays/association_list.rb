require 'erb'
require_relative 'base'

module BrainDamage
  module Displays
    class AssociationList < Base
      def initialize(options)
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
