require 'erb'

module BrainDamage
  module Inputs
    class SimpleSelect
      delegate :attribute, to: :field_description
      attr_reader :options
      attr_reader :field_description

      def initialize(options)
        @options = options
        @field_description = options[:field_description]
      end

      def html
        ERB.new(File.open("#{__dir__}/templates/collection_select.html.haml").read).result(binding)
      end
    end
  end
end
