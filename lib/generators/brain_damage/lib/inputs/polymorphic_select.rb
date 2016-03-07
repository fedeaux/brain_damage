require 'erb'
require_relative 'base'

module BrainDamage
  module Inputs
    class PolymorphicSelect < Base
      def initialize(options)
        @template_file = 'polymorphic_select.html.haml'
        super
        @normalized_name = name.to_s.gsub('_id', '').gsub('_type', '')
      end

      def type_select_name
        "#{@normalized_name}_type"
      end

      def object_select_name
        "#{@normalized_name}_id"
      end

      def options_for_type
        @options[:options].map{ |option| [option[:model].to_s, option[:model].to_s] }
      end
    end
  end
end
