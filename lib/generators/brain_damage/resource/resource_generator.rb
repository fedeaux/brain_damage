require 'rails/generators/resource_helpers'
require 'rails/generators/rails/model/model_generator'
require 'active_support/core_ext/object/blank'

require_relative '../lib/resource'

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
      args = resource.as_cmd_parameters
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
    end

    def copy_scaffold_view_files
      source_filename = "scaffold/_menu.entry.html.haml"
      target_filename = "_#{singular_table_name}.menu.entry.html.haml"

      template "views/#{source_filename}", File.join("app/views/scaffold/menu_items", target_filename)
    end

    def add_code_to_model
      @model_file_full_path = "app/models/#{name.downcase}.rb"

      return unless File.exists? @model_file_full_path

      file_contents = File.readlines @model_file_full_path
      reorder_lines = file_contents.select{ |line| line.starts_with? '  ' }

      File.open(@model_file_full_path, 'w+') do |f|
        f.write file_contents.reject{ |line| line.starts_with? '  ' }.join "\n"
      end

      @resource.add_to_model(reorder_lines).each do |stretch|
        line = if stretch =~ /^\s+$/
            then stretch
            else "\n  "+stretch.strip
          end

        inject_into_file @model_file_full_path, line, after: /class .+/, force: true
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
      BrainDamage::Resource.new get_description_file_from_args(args)
    end

    def self.get_description_file_from_args(args)
      description = args.select{ |arg|
        arg.starts_with? '--description'
      }.first

      return nil unless description

      description_file = description.split('=').last.strip.gsub('.rb', '')+'.rb'
      File.open Rails.root+'description/'+description_file
    end

    def handler
      :haml
    end
  end
end
