# frozen_string_literal: true

module Vuesfc2js
  module Conversion
    class ReplacePathAlias
      # @param [String] str
      # @param [Hash, nil] path_alias
      def initialize(str, path_alias = nil)
        @str = str
        @path_alias = path_alias
      end

      # @param [String] str
      # @param [Hash, nil] path_alias
      # @return [String]
      def self.call(str, path_alias = nil)
        return str if path_alias.nil? || path_alias.empty?

        new(str, path_alias).call
      end

      # @return [String]
      def call
        replace_path_alias(@str, @path_alias)
      end

      private

      # @param [String] str
      # @param [nil, Hash] path_alias
      def replace_path_alias(str, path_alias)
        path_alias.each do |(key, value)|
          str = str.gsub(/"#{key}/, "\"#{value}")
          str = str.gsub(/'#{key}/, "'#{value}")
        end
        str
      end
    end
  end
end
