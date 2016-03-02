require_relative 'hidden_input'
require_relative 'simple_select'

module BrainDamage
  module Inputs
    module Factory
      def self.make(name, args)
        case name
        when :hidden
          BrainDamage::Inputs::HiddenInput.new args

        when :simple_select
          BrainDamage::Inputs::SimpleSelect.new args
        end
      end
    end
  end
end
