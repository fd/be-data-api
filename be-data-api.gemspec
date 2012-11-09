# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'be-data-api/version'

Gem::Specification.new do |gem|
  gem.name          = "be-data-api"
  gem.version       = Be::Data::Api::VERSION
  gem.authors       = ["Simon Menke"]
  gem.email         = ["simon.menke@gmail.com"]
  gem.description   = %q{Data.be is the first api provider for Belgian Business Information.}
  gem.summary       = %q{Data.be API client}
  gem.homepage      = "http://github.com/fd/be-data-api"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'multi_json'
  gem.add_runtime_dependency 'excon'
end
