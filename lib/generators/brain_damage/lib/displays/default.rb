require 'erb'
require_relative 'base'

module BrainDamage
  module Displays
    class Default < Base
      def initialize(options)
        @template_file = 'default.html.haml'
        super
      end
    end
  end
end
