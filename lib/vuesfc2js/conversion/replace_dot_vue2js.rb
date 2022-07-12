# frozen_string_literal: true

require_relative "./base"

module Vuesfc2js
  module Conversion
    class ReplaceDotVue2Js
      include Vuesfc2js::Conversion::Base
      # @return [String]
      def call
        replace_dot_vue2js(@str)
      end

      private

      def replace_dot_vue2js(str)
        str.gsub(/\.vue"/, '.js"').gsub(/\.vue'/, ".js'")
      end
    end
  end
end
