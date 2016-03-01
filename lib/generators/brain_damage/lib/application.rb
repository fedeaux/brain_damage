module BrainDamage
  class Application
    @@description = nil
    attr_reader :scaffolds

    def initialize
      @scaffolds = Hash.new {}
    end

    def add_scaffold(name)
      @scaffolds[name] = BrainDamage::Scaffold.new name
      yield(@scaffolds[name]) if block_given?
    end

    def self.describe
      @@description = Application.new
      yield( @@description ) if block_given?

      puts @@description.inspect
    end

    def self.description
      @@description
    end
  end
end
