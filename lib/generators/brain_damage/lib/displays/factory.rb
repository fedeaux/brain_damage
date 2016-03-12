require_relative 'link_to'
require_relative 'default'
require_relative 'text'

module BrainDamage
  module Displays
    module Factory
      def self.make(name, args)
        name = name.to_s
        require_relative name
        "BrainDamage::Displays::#{name.camelize}".constantize.new args
      end
    end
  end
end
