require 'erb'
require_relative 'base'

module BrainDamage
  module Displays
    class Text < Base
      def initialize(options)
        @template_file = 'text.html.haml'
        super
      end
    end
  end
end
