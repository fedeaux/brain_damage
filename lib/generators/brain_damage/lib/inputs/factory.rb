require_relative 'hidden'
require_relative 'simple_select'
require_relative 'polymorphic_select'

module BrainDamage
  module Inputs
    module Factory
      def self.make(name, args)
        "BrainDamage::Inputs::#{name.to_s.camelize}".constantize.new args
      end
    end
  end
end
