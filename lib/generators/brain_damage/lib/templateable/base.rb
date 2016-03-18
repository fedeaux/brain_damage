require 'erb'

module BrainDamage
  module Templateable
    class Base
      attr_reader :options
      attr_reader :field_description
      attr_reader :inner_html

      def initialize(options)
        @options = options
        @field_description = options[:field_description]
        @template_file = "#{self.class.to_s.split('::').last.underscore}.html.haml" unless @template_file
      end

      def html(args = {})
        @html_args = args
        @encapsulated_block = args[:encapsulated_block]


        set_inner_html
        add_enclosing_haml
        include_nested_on_guard
        indent

        inner_html
      end

      def render(template_file = @template_file)
        ERB.new(File.open("#{dir}/templates/#{template_file}").read).result(binding).strip
      end

      def set_inner_html
        unless @html_args[:inner_html]
          @inner_html = render
        else
          @inner_html = @html_args[:inner_html]
        end
      end

      def add_enclosing_haml
        if @html_args[:enclosing_haml]
          if @inner_html.lines.count == 1
            @inner_html = ' '+@inner_html unless @inner_html[0] == '='
            @inner_html = @html_args[:enclosing_haml]+@inner_html
          else
            indent 1
            @inner_html = @html_args[:enclosing_haml]+"\n"+@inner_html
          end
        end
      end

      def indent(level = nil)
        level ||= @html_args[:indentation]
        @inner_html.indent! level if level
      end

      def foreign_field?
        @options and @options[:display]
      end

      def include_nested_on_guard
        false
      end

      def method_missing(method)
        @field_description.send method
      end

      class << self
        attr_accessor :template_file
      end
    end
  end
end
