$LOAD_PATH << File.expand_path('../lib', __FILE__)
require "img_lint/version"

Gem::Specification.new do |spec|
  spec.name          = "img_lint"
  spec.version       = IMGLint::VERSION
  spec.authors       = ["Anatoli Makarevich"]
  spec.email         = ["makaroni4@gmail.com"]

  spec.summary       = "IMG linter"
  spec.description   = "img-lint detects big images in your project"
  spec.homepage      = "https://github.com/makaroni4/img-lint"
  spec.license       = "MIT"

  spec.files          = Dir['config/**/*.yml'] +
                        Dir["lib/**/*.rb"] +
                        ["LICENSE.txt"]

  spec.executables   = ["img-lint"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
