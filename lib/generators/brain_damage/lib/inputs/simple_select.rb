require 'erb'

module BrainDamage
  module Inputs
    class SimpleSelect
      attr_accessor :attribute
      attr_reader :options

      def initialize(options)
        @options = options
      end

      def html
        ERB.new(File.open("#{__dir__}/templates/collection_select.html.haml").read).result(binding)
      end
    end
  end
end
