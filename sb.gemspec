require_relative "lib/sb/version"

Gem::Specification.new do |spec|
  spec.name          = "sb"
  spec.version       = Sb::VERSION
  spec.authors       = ["sb"]

  spec.summary       = "SB extensions"
  spec.homepage      = "https://github.com/secretbenefits/sb"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage

  spec.files         = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]
end
