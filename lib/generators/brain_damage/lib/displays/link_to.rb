require 'erb'
require_relative 'base'

module BrainDamage
  module Displays
    class LinkTo < Base
      def initialize(options)
        @template_file = 'link_to.html.haml'
        super
      end

      def link_text
        return "#{singular_table_name}.#{@options[:method]}.#{@options[:display]}" if foreign_field?
        "#{singular_table_name}.#{name}"
      end

      def link_target
        return "#{singular_table_name}.#{@options[:method]}" if foreign_field?
        "#{singular_table_name}"
      end

      def include_existance_check?
        foreign_field?
      end
    end
  end
end
