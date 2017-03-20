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
  spec.description   = "Load parts of your page through simple Javascript and Rails pipeline"
  spec.homepage      = "https://github.com/renderedtext/render_async"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
end
