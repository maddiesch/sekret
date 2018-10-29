lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sekret/version'

Gem::Specification.new do |spec|
  spec.name          = 'sekret'
  spec.version       = Sekret::VERSION
  spec.authors       = ['Maddie Schipper']
  spec.email         = ['me@maddiesch.com']

  spec.summary       = 'Semetric Encryption'
  spec.description   = 'Create/Decode semetric encryption'
  spec.homepage      = 'https://github.com/maddiesch/sekret'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.metadata['yard.run'] = 'yri'

  spec.files = Dir['{app,config,db,lib}/**/*', 'Rakefile', 'README.md']

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler',   '~> 1.16'
  spec.add_development_dependency 'pry',       '~> 0.10.1'
  spec.add_development_dependency 'rake',      '~> 10.0'
  spec.add_development_dependency 'rspec',     '~> 3.0'
  spec.add_development_dependency 'simplecov', '~> 0.16.1'
  spec.add_development_dependency 'yard',      '~> 0.9.16'
end
