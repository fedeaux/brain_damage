require_relative 'lib/application'
require_relative 'lib/scaffold'

class BrainDamageGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  class_option :destroy, :type => :boolean, :default => false, :description => "Should destroy the application instead of creating it"
  class_option :install, :type => :boolean, :default => false, :description => "Add basic files"

  def install
    if options.install?
      copy_file "brain_damage_helper.rb", "app/helpers/brain_damage_helper.rb"
      copy_file "brain-damage.css.sass", "app/assets/stylesheets/brain-damage.css.sass"
      directory "javascripts/", "app/assets/javascripts/brain_damage/"
    end
  end

  def create
    unless options.destroy?
      puts "Creating BrainDamage App"
      require Rails.root+'app/description'

      BrainDamage::Application.description.scaffolds.each do |name, scaffold_info|
        scaffold_generator = BrainDamage::Scaffold.new name, scaffold_info
        scaffold_generator.create
      end
    end
  end

  def destroy
    if options.destroy?
      puts "Destroying BrainDamage App"
      require Rails.root+'app/description'
      BrainDamage::Application.description.scaffolds.each do |name, scaffold_info|
        `rake db:rollback`
      end

      BrainDamage::Application.description.scaffolds.each do |name, scaffold_info|
        `rails d scaffold #{name}`
      end
    end
  end
end
