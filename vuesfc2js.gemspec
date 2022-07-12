# frozen_string_literal: true

require_relative "lib/vuesfc2js/version"

Gem::Specification.new do |spec|
  spec.name = "vuesfc2js"
  spec.version = Vuesfc2js::VERSION
  spec.authors = ["junara"]
  spec.email = ["jun5araki@gmail.com"]

  spec.summary = "Extract script part from Vue SFC and convert to JavaScript."
  spec.description = "Extract script part from Vue SFC and convert to JavaScript."
  spec.homepage = "https://github.com/junara/vuesfc2js"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata["documentation_uri"] = "https://rubydoc.info/gems/vuesfc2js"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "factory_bot"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-parameterized"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-performance"
  spec.add_development_dependency "rubocop-rake"
  spec.add_development_dependency "rubocop-rspec"

  spec.metadata["rubygems_mfa_required"] = "true"
end
