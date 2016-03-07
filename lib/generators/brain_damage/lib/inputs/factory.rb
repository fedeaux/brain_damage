module BrainDamage
  module Inputs
    module Factory
      def self.make(name, args)
        name = name.to_s
        require_relative name
        "BrainDamage::Inputs::#{name.camelize}".constantize.new args
      end
    end
  end
end
