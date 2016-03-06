require 'erb'
require_relative 'base'

module BrainDamage
  module Inputs
    class SimpleSelect < Base
      def initialize(options)
        @template_file = 'collection_select.html.haml'
        super
      end
    end
  end
end
