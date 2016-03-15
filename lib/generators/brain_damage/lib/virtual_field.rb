module BrainDamage
  class VirtualField
    attr_accessor :name

    def initialize(name, description)
      @name = name
      @description = description
    end

    def field_type
      false
    end

    def human_name
      @name.to_s.humanize
    end

    def white_list
      if @description[:relation]
        if @description[:relation][:type] == :has_many
          if @description[:input]
            if @description[:input][:white_list]
              return ":#{name.to_s.pluralize}_attributes => #{@description[:input][:white_list].inspect}"

            elsif @description[:input] and @description[:input][:unnested_white_list]
              return @description[:input][:unnested_white_list].map { |name, value|
                ":#{name} => #{value.inspect} "
              }

            end
          else
            return ":#{name} => []"

          end
        end
      end

      nil
    end
  end
end
