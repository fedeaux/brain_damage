require 'rails/generators'

namespace :bd do
  desc "Destroy everything and recreate from scratch"
  task recreate: :environment do
    Rails::Generators.invoke("brain_damage:app", ["--destroy=true"])
    Rails::Generators.invoke("brain_damage:app")
    # Rake::Task["db:migrate"].invoke
  end

  task create: :environment do
    Rails::Generators.invoke("brain_damage:app")
    # Rake::Task["db:migrate"].invoke
  end

  task destroy: :environment do
    Rails::Generators.invoke("brain_damage:app", ["--destroy=true"])
  end
end
