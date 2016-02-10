require 'rails/generators'

module BrainDamage
  class Scaffold
    @@current_scaffold = nil

    def self.current_scaffold
      @@current_scaffold
    end

    def initialize(name, args)
      @scaffold_command = nil
      @name = name
      @args = parse_args args
    end

    def create
      @@current_scaffold = self

      Rails::Generators.invoke "scaffold", [@name, @fields_as_parameters,
        '--template-engine=haml', '--no-assets', '--orm=active_record', '--migration'],
        { migration: true, timestamps: true }
    end

    private
    def parse_args(args)
      @fields_as_parameters = args[:fields].map{ |name, type| "#{name}:#{type}" }
    end

    def available_views
      %w(index show _form _fields _single_page_manager _table.item _table.header _table.form _table.item.form)
    end

  end
end
