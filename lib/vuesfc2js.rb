# frozen_string_literal: true

require "fileutils"
require_relative "vuesfc2js/version"
require_relative "vuesfc2js/error/not_exist_error"
require_relative "vuesfc2js/error/not_implemented_error"
require_relative "vuesfc2js/conversion/script_extraction"
require_relative "vuesfc2js/conversion/replace_dot_vue2js"
require_relative "vuesfc2js/conversion/replace_filename_dot_vue2js"
require_relative "vuesfc2js/conversion/replace_path_alias"

module Vuesfc2js
  module_function

  # Convert code like SFC to js.
  # @param [String] str
  # @param [nil, Hash] path_alias
  # @param [String] extname
  # @return [String]
  def convert_str(str, path_alias: nil, extname: ".vue")
    str = extname == ".vue" ? Conversion::ScriptExtraction.call(str) : str
    str = Conversion::ReplaceDotVue2Js.call(str)
    path_alias.nil? ? str : Conversion::ReplacePathAlias.call(str, path_alias)
  end

  # Get filename having js extname from vue extname file.
  # @param [String] filename
  # @return [String]
  def filename(filename)
    Conversion::ReplaceFilenameDotVue2Js.call(filename)
  end

  # Convert a file.
  # @param [String] filename
  # @param [nil, Hash] path_alias
  # @param [Array<String>] extnames
  # @param [FalseClass, TrueClass] replace if replace .vue file to .js file, set true.
  def convert_file(filename, path_alias: nil, extnames: %w[.vue .js], replace: false)
    raise "Only .vue or .js is permitted" if (extnames - %w[.vue .js]).size >= 1

    extname = File.extname(filename)
    return unless extnames.include?(extname)

    raise Error::NotExistError, "#{filename} is not existed." unless File.exist?(filename)

    str = File.read(filename)
    str = convert_str(str, path_alias: path_alias, extname: extname)

    File.write(filename(filename), str)

    File.delete(filename) if replace && File.extname(filename) == ".vue"
    filename
  end

  # Convert a directory.
  # @param [String] dir
  # @param [nil, Hash] path_alias
  # @param [Array<String>] extnames
  # @param [FalseClass, TrueClass] replace if replace .vue file to .js file, set true.
  def convert_directory(dir, path_alias: nil, extnames: %w[.vue .js], replace: false)
    raise Error::NotExistError, "#{dir} is not existed." unless Dir.exist?(dir)

    Dir.glob((Pathname.new(dir) + Pathname.new("**/*")).to_s).each do |filename|
      convert_file(filename, path_alias: path_alias, extnames: extnames, replace: replace)
    end
  end

  # @param [String] src
  # @param [String] dst
  # @param [nil, Hash] src_path_alias
  # @param [Array<String>] extnames
  # @param [FalseClass, TrueClass] replace if replace .vue file to .js file, set true.
  def convert_vue_project(src, dst, src_path_alias: nil, extnames: %w[.vue .js], replace: false)
    check_params(src, dst)
    src_pathname = Pathname.new(src).expand_path
    dst_pathname = Pathname.new(dst)
    new_src_pathname = dst_pathname + src_pathname.basename
    path_alias = shift_path_alias(src_path_alias, new_src_pathname, src_pathname)
    p "Converting #{src_pathname} to #{new_src_pathname}..."
    cp_r(src_pathname, dst_pathname)
    convert_directory(new_src_pathname.to_s, path_alias: path_alias, extnames: extnames, replace: replace)
  end

  def check_params(src, dst)
    check_src(src)
    check_dst(dst)
  end
  private_class_method :check_params

  def check_src(src)
    src_pathname = Pathname.new(src).expand_path
    raise "#{src} must be absolute path." if src_pathname.relative?
    raise "#{src} must be directory." unless src_pathname.directory?
  end
  private_class_method :check_src

  # @param [String] dst
  def check_dst(dst)
    dst_pathname = Pathname.new(dst)
    raise "#{dst} is already existed." if dst_pathname.exist? || dst_pathname.directory?
  end
  private_class_method :check_dst

  # Copy directory like cp -r.
  # @param [Pathname] src_pathname
  # @param [Pathname] dst_pathname
  def cp_r(src_pathname, dst_pathname)
    dst_pathname.mkdir
    FileUtils.cp_r(src_pathname.to_s, dst_pathname.to_s)
  end
  private_class_method :cp_r

  def shift_path_alias(src_path_alias, new_src_pathname, src_pathname)
    return if src_path_alias.nil?

    src_path_alias.transform_values do |value|
      alias_pathname = Pathname.new(value)
      raise "#{value} must be absolute." if alias_pathname.relative?
      raise "#{value} must be directory." unless alias_pathname.directory?

      new_alias_pathname = new_src_pathname + alias_pathname.relative_path_from(src_pathname)
      new_alias_pathname.expand_path.to_s
    end
  end
  private_class_method :shift_path_alias
end
