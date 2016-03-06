require 'erb'
require_relative 'base'

module BrainDamage
  module Displays
    class LinkTo < Base
      def initialize(options)
        @template_file = 'link_to.html.haml'
        super
      end
    end
  end
end
