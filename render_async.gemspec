# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'render_async/version'

Gem::Specification.new do |spec|
  spec.name          = "render_async"
  spec.version       = RenderAsync::VERSION
  spec.authors       = ["Kasper Grubbe", "nikolalsvk"]
  spec.email         = ["nikolaseap@gmail.com"]

  spec.summary       = "Render parts of the page asynchronously with AJAX"
  spec.description   = "Load parts of your page through simple JavaScript and Rails pipeline"
  spec.homepage      = "https://github.com/renderedtext/render_async"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 1.0.8"
end
