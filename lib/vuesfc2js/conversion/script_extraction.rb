# frozen_string_literal: true

require_relative "./base"

module Vuesfc2js
  module Conversion
    class ScriptExtraction
      include Vuesfc2js::Conversion::Base

      # @return [String]
      def call
        extract_script(@str)
      end

      private

      def extract_script(str)
        str.scan(%r{<script.*>\n(.*)</script>}m).join
      end
    end
  end
end
