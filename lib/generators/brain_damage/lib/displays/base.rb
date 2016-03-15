require_relative '../templateable/base'

module BrainDamage
  module Displays
    class Base < Templateable::Base
      def initialize(options)
        super
      end

      def input_html(args = {})
        field_description.input.html(args)
      end

      def include_nested_on_guard?
        field_description.relation and field_description.relation.type == :belongs_to
      end

      def include_nested_on_guard
        if include_nested_on_guard? and !@html_args[:skip_include_nested_on_guard]
          @inner_html = ERB.new(File.open("#{dir}/templates/nested_on_guard.html.haml").read).result(binding).strip
        end
      end

      def dir
        __dir__
      end
    end
  end
end
