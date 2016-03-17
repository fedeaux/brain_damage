module BrainDamage
  module Plugins
    module Factory
      def self.make(name, args)
        name = name.to_s
        require_relative "#{name}/#{name}"
        "BrainDamage::Plugins::#{name.camelize}".constantize.new args
      end
    end
  end
end
