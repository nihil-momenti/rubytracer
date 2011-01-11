# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rubytracer/version"

Gem::Specification.new do |s|
  s.name        = "rubytracer"
  s.version     = RubyTracer::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nemo157 (Wim Looman)"]
  s.email       = ["ghostunderscore@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A simple pure ruby raytracer library}
  s.description = %q{A simple pure ruby raytracer library}
  s.licenses    = ["Apache License 2.0"]

  s.rubyforge_project = "rubytracer"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.required_ruby_version = '>1.9.2'

  s.add_runtime_dependency 'geom3d', '~>0.0.1'

  s.add_development_dependency 'rspec', '~>2.3.0'
end
