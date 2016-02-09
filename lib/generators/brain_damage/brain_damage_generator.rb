class BrainDamageGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def copy_helper_file
    copy_file "brain_damage_helper.rb", "app/helpers/brain_damage_helper.rb"
  end

  def copy_style_file
    copy_file "brain-damage.css.sass", "app/assets/stylesheets/brain-damage.css.sass"
  end

  def copy_javascript_files
    directory "javascripts/", "app/assets/javascripts/brain_damage/"
  end
end
