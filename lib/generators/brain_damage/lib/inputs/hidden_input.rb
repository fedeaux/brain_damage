require_relative 'base'

module BrainDamage
  module Inputs
    class HiddenInput < Base
      attr_accessor :attribute

      def initialize(options)
      end

      def html
        ''
      end
    end
  end
end
