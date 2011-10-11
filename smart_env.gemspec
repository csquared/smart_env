# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "smart_env/version"

Gem::Specification.new do |s|
  s.name        = "smart_env"
  s.version     = SmartEnv::VERSION
  s.authors     = ["Chris Continanza"]
  s.email       = ["christopher.continanza@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Lazily proxy ENV values}
  s.description = %q{Allows you to register Proxy classes for ENV vars by using blocks to match keys and values}

  s.rubyforge_project = "smart_env"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_development_dependency 'rspec', '~> 2.0'
  s.add_development_dependency 'rcov'
end
