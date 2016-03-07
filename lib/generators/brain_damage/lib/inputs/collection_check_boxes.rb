require 'erb'
require_relative 'base'

module BrainDamage
  module Inputs
    class CollectionCheckBoxes < Base
      def initialize(options)
        @template_file = 'collection_check_boxes.html.haml'
        super
      end
    end
  end
end
