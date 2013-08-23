# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'render_async/version'

Gem::Specification.new do |spec|
  spec.name          = "render_async"
  spec.version       = RenderAsync::VERSION
  spec.authors       = ["Kasper Grubbe"]
  spec.email         = ["kawsper@gmail.com"]
  spec.description   = %q{RenderAsync lets you include pages asynchronously with AJAX}
  spec.summary       = %q{RenderAsync lets you include pages asynchronously with AJAX}
  spec.homepage      = "https://github.com/kaspergrubbe/render_async"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
