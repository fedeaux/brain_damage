module BrainDamage
  class FullGenerator < Rails::Generators::Base
    class_option :descriptions, desc: "The .rb files", :optional => true, :default => '*'
    class_option :destroy, desc: "Destroy instead of creat", :optional => true, :default => false

    def just_do_it
      action = options[:destroy] ? 'd' : 'g'

      descriptions = if options[:descriptions] == '*'
        then
          Dir["description/*"].map { |description|
            if description[-3, 3] == '.rb' then
              description.split('/').last
            else
              nil
            end
          }.reject(&:nil?)
      else
        options[:descriptions].split(',').map(&:strip)
      end

      descriptions.each do |description|
        system "rails #{action} brain_damage:resource --description=#{description} -p"
      end
    end
  end
end
