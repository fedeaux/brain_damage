require 'test_helper'
require 'generators/brain_damage/brain_damage_generator'

class BrainDamageGeneratorTest < Rails::Generators::TestCase
  tests BrainDamageGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
