# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "traffic/version"

Gem::Specification.new do |s|
  s.name        = "traffic"
  s.version     = Traffic::VERSION
  s.authors     = ["Daniel van Hoesel"]
  s.email       = ["daniel@danielvanhoesel.nl"]
  s.homepage    = ""
  s.summary     = %q{Traffic: the traffic information gem}
  s.description = %q{Traffic is a gem that supplies traffic information from multiple data providers}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency('bundler', '~> 1.0')
  s.add_development_dependency('rake', '~> 0.9')
  s.add_development_dependency('rspec', '~> 2.7')
  s.add_development_dependency('mocha', '~> 0.10')
  s.add_development_dependency('simplecov', '~> 0.5')
  s.add_development_dependency('fakeweb', '~> 1.3')
  s.add_dependency('feedzirra', '~> 0.1.1')
end
