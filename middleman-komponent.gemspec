# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'middleman-komponent/version'

Gem::Specification.new do |s|
  s.name        = "middleman-komponent"
  s.version     = Middleman::Komponent::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Komposable"]
  s.email       = ["contact@komposable.io"]

  s.summary     = "An opinionated way of organizing front-end code in Middleman, based on components"
  s.description = "An opinionated way of organizing front-end code in Middleman, based on components"
  s.homepage    = "http://komponent.io"
  s.license = "MIT"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # The version of middleman-core your extension depends on
  s.add_runtime_dependency("middleman-core", [">= 4.2.1"])

  # Additional dependencies
  # s.add_runtime_dependency("gem-name", "gem-version")
end
