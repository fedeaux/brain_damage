require 'rails/generators/resource_helpers'
require 'rails/generators/rails/model/model_generator'
require 'active_support/core_ext/object/blank'

require_relative '../lib/resource'
require_relative 'monkeys/string'

module BrainDamage
  class ResourceGenerator < Rails::Generators::ModelGenerator
    include Rails::Generators::ModelHelpers
    include Rails::Generators::ResourceHelpers
    source_root File.expand_path('../templates', __FILE__)

    class_option :description, desc: "The .rb file with description for this scaffold"

    # BRAIN_DAMAGE_MODEL_HOOK_TEXT_START = "\n  # BD: Code automatically generated by BrainDamage."
    # BRAIN_DAMAGE_MODEL_HOOK_TEXT_END = "\n  # BD: Outside these two comments is safe to edit."

    hook_for :resource_route, required: true, in: :rails

    class << self
      attr_accessor :resource
    end

    def self.start(args, config)
      self.resource = get_resource_description args

      args = resource.as_cmd_parameters + ['--force'] # always force viewes
      @ignore_migration = self.resource.ignore_migration?

      if @ignore_migration
        args << '--no-migration'
      end

      super
    end

    def set_resource_object
      @resource = self.class.resource
      @resource.generator = self
    end

    def create_controller_files
      template "controller.rb", File.join('app/controllers', controller_class_path, "#{controller_file_name}_controller.rb")
    end

    def copy_view_files
      @resource.views_manager.available_views.each do |view|
        source_filename = "#{view}.html.haml"
        target_filename = "#{view.split('/').last}.html.haml"
        template "views/#{source_filename}", File.join("app/views", controller_file_path, target_filename)
      end

      @resource.views_manager.dynamic_views.each do |dynamic_view|
        target_filename = "#{dynamic_view[:file_name]}.html.haml"
        create_file File.join("app/views", controller_file_path, target_filename), dynamic_view[:contents]
      end

    end

    def copy_scaffold_view_files
      source_filename = "scaffold/_menu.entry.html.haml"
      target_filename = "_#{singular_table_name}.menu.entry.html.haml"

      template "views/#{source_filename}", File.join("app/views/scaffold/menu_items", target_filename)
    end

    def improve_model_code
      model_file_full_path = "app/models/#{name.underscore}.rb"

      return unless File.exists? model_file_full_path

      file_contents = File.read model_file_full_path

      File.open(model_file_full_path, 'w+') do |f|
        f.write @resource.improve_model_code file_contents
      end
    end

    def improve_migration_code
      return if @ignore_migration
      file_name = @resource.migration_file_full_path

      return unless file_name and File.exists? file_name
      file_contents = File.read file_name

      File.open(file_name, 'w+') do |f|
        f.write @resource.improve_migration_code file_contents
      end
    end

    protected
    def all_fields
      attributes + @resource.virtual_fields
    end

    def attribute_white_list
      (attributes_names.map { |name| ":#{name}" } + @resource.virtual_fields_white_list).join(', ')
    end

    def self.get_resource_description(args)
      initializers = [get_helpers_file, get_description_file_from_args(args)].reject(&:nil?)
      BrainDamage::Resource.new initializers
    end

    def self.get_helpers_file
      helpers_file = Rails.root+'description/helpers.rb'
      return File.open helpers_file if File.exists? helpers_file
    end

    def self.get_description_file_from_args(args)
      description = args.select{ |arg|
        arg.starts_with? '--description' or arg.starts_with? '-d'
      }.first

      return nil unless description

      file_name = description.split('=').last.strip

      if file_name =~ /^\d+/
        full_file_name = Rails.root+'description/'+file_name

      else
        # Try to find a directory
        file_glob = '*.'+file_name
        full_file_name = Dir[Rails.root+'description/'+file_glob].first

        if full_file_name.blank?
          # No directory? Try a file
          file_glob += '.rb'
          full_file_name = Dir[Rails.root+'description/'+file_glob].first
        end
      end

      if full_file_name.blank?
        raise "Couldn't find any file related with #{description}"
      else
        if File.directory? full_file_name
          return File.open "#{full_file_name}/#{file_name.gsub(/^\d+\./, '')}.rb"
        end

        return File.open full_file_name
      end
    end

    def handler
      :haml
    end
  end
end
