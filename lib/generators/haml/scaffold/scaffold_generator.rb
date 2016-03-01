require 'rails/generators/erb/scaffold/scaffold_generator'
require_relative '../../brain_damage/lib/scaffold'

module Haml
  module Generators
    class ScaffoldGenerator < Erb::Generators::ScaffoldGenerator
      source_root File.expand_path("../templates", __FILE__)

      def copy_view_files
        available_views.each do |view|
          filename = filename_with_extensions(view)
          template "views/#{view}.html.haml", File.join("app/views", controller_file_path, filename)
        end
      end

      def vsf
        puts methods.join " "
      end

    protected
      def current_scaffold
        BrainDamage::Scaffold.current_scaffold
      end

      def available_views
        %w(index show _form _fields _single_page_manager _table.item _table.header _table.form _table.item.form)
      end

      def handler
        :haml
      end

    end
  end
end
