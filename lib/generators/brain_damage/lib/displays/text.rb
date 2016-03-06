require 'erb'

module BrainDamage
  module Displays
    class Text
      def initialize(options)
        @template_file = 'text.html.haml'
        super
      end
    end
  end
end
