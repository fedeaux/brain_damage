require_relative 'link_to'
require_relative 'default'
require_relative 'text'

module BrainDamage
  module Displays
    module Factory
      def self.make(name, args)
        case name
        when :link_to
          BrainDamage::Displays::LinkTo.new args

        when :text
          BrainDamage::Displays::Text.new args

        else
          BrainDamage::Displays::Default.new args

        end
      end
    end
  end
end
