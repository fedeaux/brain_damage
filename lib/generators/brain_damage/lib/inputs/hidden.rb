require_relative 'base'

module BrainDamage
  module Inputs
    class Hidden < Base
      attr_accessor :attribute

      def initialize(options)
      end

      def html(args = {})
        ''
      end
    end
  end
end
