module BrainDamage
  class Application
    @@description = nil
    attr_reader :scaffolds

    def initialize
      @scaffolds = Hash.new {}
    end

    def add_scaffold(name)
      scaffold = BrainDamage::Scaffold.new name
      yield(scaffold) if block_given?
      @scaffolds[name] = scaffold
    end

    def self.describe
      @@description = BrainDamage::Application.new
      yield( @@description ) if block_given?
    end

    def self.description
      @@description
    end

    def make
      scaffolds.each do |name, scaffold|
        puts "Creating #{name}"
        puts scaffold.inspect
        scaffold.create
      end
    end
  end
end
