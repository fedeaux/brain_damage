require 'rails/generators'

namespace :bd do
  desc "Destroy everything and recreate from scratch"
  task recreate: :environment do
    Rails::Generators.invoke("brain_damage", ["--destroy=true"])
    Rails::Generators.invoke("brain_damage")
  end

  task create: :environment do
    Rails::Generators.invoke("brain_damage")
  end

  task destroy: :environment do
    Rails::Generators.invoke("brain_damage", ["--destroy=true"])
  end
end
