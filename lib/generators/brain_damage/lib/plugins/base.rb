require_relative '../templateable/base'

module BrainDamage
  module Plugins
    class Base < Templateable::Base
      attr_reader :type

      def initialize
      end

      def leading_controller_code
      end

      def trailing_controller_code
      end

      def leading_model_code
      end

      def trailing_model_code
      end

      def dir
        __dir__
      end
    end
  end
end
