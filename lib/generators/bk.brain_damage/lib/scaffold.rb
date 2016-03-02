# -*- coding: utf-8 -*-
module BrainDamage
  class Scaffold
    @@current_scaffold = nil

    attr_accessor :fields
    attr_accessor :name
    attr_accessor :views
    attr_accessor :view_schema
    attr_accessor :form_fields

    def self.current_scaffold
      @@current_scaffold
    end

    def initialize(name, args = {})
      @scaffold_command = nil
      @name = name
      @args = args
      @fields = {}

      yield(self) if block_given?
    end

    def create
      return if @fields.empty?
      @@current_scaffold = self

      # `rails g scaffold #{[@name, fields_as_parameters,
      #   '--template-engine=haml', '--no-assets', '--orm=active_record', '--migration'].join(' ')}`

      Rails::Generators.invoke "scaffold", [@name, fields_as_parameters,
        '--template-engine=haml', '--no-assets', '--orm=active_record', '--migration'],
        behavior: :invoke, destination_root: Rails.root, migration: true, timestamps: true

      # { migration: true, timestamps: true }
    end

    def fields_as_parameters
      @fields.map { |name, type| field_as_parameter name, type }.join ' '
    end

    def field_as_parameter(name, type)
      "#{name.to_s}:#{type.to_s}"
    end

    private

    def available_views
      %w(index show _form _fields _single_page_manager _table.item _table.header _table.form _table.item.form)
    end
  end
end
