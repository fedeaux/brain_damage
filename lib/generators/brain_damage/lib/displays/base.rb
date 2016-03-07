require 'erb'

module BrainDamage
  module Displays
    class Base
      attr_reader :options
      attr_reader :field_description

      def initialize(options)
        @options = options
        @field_description = options[:field_description]
      end

      def html
        ERB.new(File.open("#{__dir__}/templates/#{@template_file}").read).result(binding)
      end

      def foreign_field?
        @options and @options[:display]
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
