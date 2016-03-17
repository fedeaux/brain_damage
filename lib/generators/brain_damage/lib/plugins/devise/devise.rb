require_relative '../base'

module BrainDamage
  module Plugins
    class Devise < Base
      def initialize
      end

      def leading_controller_code
        ["before_action :authenticate_#{name}!"]
      end
    end
  end
end
