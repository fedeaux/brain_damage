require 'erb'
require_relative 'base'

module BrainDamage
  module Displays
    class Unexistent < Base
      def initialize(options)
        super
      end

      def html(args = {})
        false
      end
    end
  end
end
