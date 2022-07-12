# frozen_string_literal: true

module Vuesfc2js
  module Conversion
    module Base
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        # @param [String] str
        def call(str)
          new(str).call
        end
      end

      # @param [String] str
      def initialize(str)
        @str = str
      end

      # @return [String]
      def call
        raise NotImplementedError, "call is not implemented"
      end
    end
  end
end
