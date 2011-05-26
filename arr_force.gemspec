# -*- encoding: utf-8 -*-
require File.expand_path('../lib/arr_force/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'arr-force'
  gem.version     = ArrForce::VERSION
  gem.author      = "Steve Agalloco"
  gem.email       = 'steve.agalloco@gmail.com'
  gem.homepage    = 'https://github.com/spagalloco/arr-force'
  gem.summary     = %q{Faraday Middleware to ensure certain keys are converted to arrays}
  gem.description = %q{Faraday Middleware to ensure certain keys are converted to arrays}

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  gem.require_paths = ['lib']

  gem.add_development_dependency 'ZenTest', '~> 4.5'
  gem.add_development_dependency 'maruku', '~> 0.6'
  gem.add_development_dependency 'rake', '~> 0.9'
  gem.add_development_dependency 'rspec', '~> 2.6'
  gem.add_development_dependency 'simplecov', '~> 0.4'
  gem.add_development_dependency 'yard', '~> 0.7'

  gem.add_dependency 'faraday', '0.6'
end
