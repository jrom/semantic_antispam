# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "semantic_antispam/version"

Gem::Specification.new do |s|
  s.name        = "semantic_antispam"
  s.version     = Semantic::Antispam::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jordi Romero"]
  s.email       = ["jordi@jrom.net"]
  s.homepage    = "http://github.com/jrom/semantic_antispam"
  s.summary     = %q{Simple semantic antispam solution for ActiveRecord-based applications.}
  s.description = %q{Define questions and answers in a YAML file and validate your models with a single line of code. No more captchas or other stupid tricks.}

  s.files         = `git ls-files`.split("\n") - ['.gitignore', '.rspec', 'autotest/discover.rb']
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # Dependencies
  s.add_dependency "activerecord", ">= 3.0.0"
  s.add_development_dependency "rspec", "~> 2.0.0.rc"
  s.add_development_dependency "autotest", "~> 4.4.1"
  s.add_development_dependency "sqlite3-ruby", "~> 1.3.1"
end
