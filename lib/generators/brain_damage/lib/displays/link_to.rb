require 'erb'

module BrainDamage
  module Displays
    class LinkTo
      def initialize(options)
        @template_file = 'link_to.html.haml'
        super
      end
    end
  end
end
