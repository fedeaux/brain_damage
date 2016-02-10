module BrainDamage
  class Scaffold
    def initialize(name, args)
      @scaffold_command = nil
      @name = name
      @args = parse_args args
    end

    def create
      `#{@scaffold_command}`
    end

    private
    def parse_args(args)
      fields_as_string = args[:fields].map{ |name, type| "#{name}:#{type}" }.join ' '
      @scaffold_command = "rails g scaffold #{@name} #{fields_as_string} --no-assets --template-engine=haml"
    end
  end
end
