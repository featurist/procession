# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "procession/version"

Gem::Specification.new do |s|
  s.name        = 'procession'
  s.version     = Procession::VERSION
  s.authors     = ["Josh Chisholm"]
  s.email       = "josh@featurist.co.uk"
  s.description = 'Runs a process and blocks until it starts properly'
  s.summary     = "procession-#{s.version}"
  s.homepage    = "http://github.com/featurist/procession"

  s.platform    = Gem::Platform::RUBY

  s.add_runtime_dependency 'childprocess', '>= 0.3.8'
  
  s.add_development_dependency 'rspec-expectations', '>= 2.0.1'
  s.add_development_dependency 'rack', '>= 1.5.2'

  s.rubygems_version = ">= 1.6.1"
  s.files            = `git ls-files`.split("\n").reject {|path| path =~ /\.gitignore$/ }
  s.test_files       = `git ls-files -- {spec}/*`.split("\n")
  s.executables      = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.rdoc_options     = ["--charset=UTF-8"]
  s.require_path     = "lib"
end
