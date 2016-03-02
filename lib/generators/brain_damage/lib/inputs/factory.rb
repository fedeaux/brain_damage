require_relative 'hidden_input'

module BrainDamage
  module Inputs
    module Factory
      def self.make(name, args)
        case name
        when :hidden
          BrainDamage::Inputs::HiddenInput.new args
        end
      end
    end
  end
end
