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

    def available_views
      %w(index show _form _fields _single_page_manager _table.item _table.header _table.form _table.item.form)
    end

  end
end
