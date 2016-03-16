module BrainDamage
  class ModelAdapter
    def self.improve_model_code(resource, model_code)
      new(resource).improve_model_code model_code
    end

    def initialize(resource)
      @resource = resource
    end

    def improve_model_code(model_code)
      @model_lines = model_code.split "\n"

      return model_code if @model_lines.length == 2

      break_model_down
      improve_belongs_to_lines
      add_validations_lines
      add_lines_from_fields_descriptions
      prettify_model_lines
      remake_model
    end

    def break_model_down
      @model_header = [ @model_lines.first ]
      @model_footer = [ @model_lines.last ]
      @model_content_lines = @model_lines[1, @model_lines.length - 2].each_with_index.to_a
    end

    def improve_belongs_to_lines
      belongs_to_lines = @model_content_lines.select { |pair|
        pair.first.include? 'belongs_to'
      }.map { |pair|
        line = pair.first
        parts = line.split(', ')

        improve_belongs_to_line(
                                index: pair.second,
                                indentation_level: line.indentation_level,
                                related_field: line.scan(/:(\w+)/).first.first.to_sym,
                                options: parts[1, parts.length - 1] || []
                               )
      }

      belongs_to_lines.each do |line_info|
        @model_content_lines[line_info.second] = line_info.first
      end
    end

    def improve_belongs_to_line(l)
      new_line = "belongs_to :#{l[:related_field]}"
      options_string = eval_belongs_to_options_string l

      new_line = (new_line + options_string).indent l[:indentation_level]

      [new_line, l[:index]]
    end

    def eval_belongs_to_options_string(l)
      options = l[:options]

      if @resource.fields[l[:related_field]] and @resource.fields[l[:related_field]].is_a? Hash
        field_options = @resource.fields[l[:related_field]].dup
        field_options.delete :type
        options << field_options.map { |key, value|
          "#{key}: '#{value}'"
        }
      end

      options = [''] + options if options.length > 0
      options.join ', '
    end

    def remake_model
      (@model_header + @model_content_lines + @model_footer).join "\n"
    end

    def adapt_model_lines(lines)
      @lines = lines

      adapt_belongs_to_lines

      @lines
    end

    def add_validations_lines
      @model_content_lines += @resource.validations.add_to_model.map(&:indent) if @resource.validations
    end

    def add_lines_from_fields_descriptions
      @model_content_lines += @resource.fields_descriptions.values.map(&:add_to_model).flatten.reject(&:nil?).map(&:indent)
    end

    def prettify_model_lines
      return if @model_content_lines.empty?

      pairs = @model_content_lines.map { |line|
        i = case line
            when /validates/
              0

            when /accepts/
              2

            else
              1
            end

        [ line, i]
      }.sort { |pair_a, pair_b|
        natural = pair_a[1] <=> pair_b[1]
        if natural != 0 then natural else pair_a[0] <=> pair_b[0] end

      }

      current_i = pairs.first[1]

      lines = []
      pairs.each do |pair|
        if pair[1] != current_i
          lines << ""
          current_i = pair[1]
        end

        lines << pair[0]
      end

      @model_content_lines = lines
    end
  end
end
