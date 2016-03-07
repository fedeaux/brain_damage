module BrainDamage
  class VirtualField
    attr_accessor :name

    def initialize(name)
      @name = name
    end

    def field_type
      false
    end
  end
end
