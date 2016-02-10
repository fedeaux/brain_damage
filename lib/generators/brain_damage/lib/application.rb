module BrainDamage
  class Application
    @@description = nil
    attr_reader :scaffolds

    def initialize
      @scaffolds = Hash.new {}
    end

    def self.describe(&block)
      @@description = Application.new
      block.call @@description
    end

    def self.description
      @@description
    end
  end
end
