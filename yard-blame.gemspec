# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "yard-blame/version"

Gem::Specification.new do |s|
  s.name        = "yard-blame"
  s.version     = Yard::Blame::VERSION
  s.authors     = ["Andrew O'Brien"]
  s.email       = ["obrien.andrew@gmail.com"]
  s.homepage    = "http://github.com/AndrewO/yard-blame"
  s.summary     = %q{Adds git-blame output to YARD docs}
  s.description = %q{Who wrote that code? When? Why? Theses are all things we often ask when reading documentation. yard-blame makes it easy to ask.}

  s.rubyforge_project = "yard-blame"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "yard"
end
