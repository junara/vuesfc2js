# frozen_string_literal: true

require_relative "./base"

module Vuesfc2js
  module Conversion
    class ReplaceFilenameDotVue2Js
      include Vuesfc2js::Conversion::Base
      # @return [String]
      def call
        replace_filename_dot_vue2js(@str)
      end

      private

      # @param [String] filename
      # @return [String]
      def replace_filename_dot_vue2js(filename)
        if File.extname(filename) == ".vue"
          [File.dirname(filename), "#{File.basename(filename, ".vue")}.js"].join("/")
        else
          [File.dirname(filename), File.basename(filename)].join("/")
        end
      end
    end
  end
end
