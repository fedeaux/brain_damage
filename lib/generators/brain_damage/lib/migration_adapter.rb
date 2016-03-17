module BrainDamage
  class MigrationAdapter
    def self.improve_migration_code(resource, migration_code)
      new(resource).improve_migration_code migration_code
    end

    def initialize(resource)
      @resource = resource
    end

    def improve_migration_code(migration_code)
      @migration_lines = migration_code.split "\n"

      return migration_code if @migration_lines.length == 2

      add_options_to_lines
      remake_migration
    end

    def is_column_line? line
      line =~ /t\..*:\w+/
    end

    def add_options_to_lines
      @migration_lines.map! { |line|
        if is_column_line? line
          related_field = line.scan(/:(\w+)/).first.first.to_sym
          field_options = @resource.fields[related_field] || {}

          add_options line, related_field, field_options
        else
          line
        end
      }
    end

    def add_options(line, related_field, field_options)
      options = belongs_to_options line, related_field, field_options

      field_options.slice(:default, :precision, :scale).each do |key, value|
        options << "#{key}: #{value.inspect}"
      end

      options = [''] + options if options.length > 0
      line + options.join(', ')
    end

    def belongs_to_options(line, related_field, field_options)
      return [] unless is_belongs_to_line? line
      return ["references: :#{field_options[:class_name].underscore.pluralize}"] if field_options[:class_name]
      []
    end

    def is_belongs_to_line? line
      line.include? 't.belongs_to'
    end

    def remake_migration
      @migration_lines.join "\n"
    end
  end
end
