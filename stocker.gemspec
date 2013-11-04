# -*- encoding: utf-8 -*-
require File.expand_path('../lib/stocker', __FILE__)

Gem::Specification.new do |s|
  s.add_dependency "nokogiri", ""
  s.add_development_dependency "bundler", "~> 1.0"
  s.add_development_dependency "rdoc", "~> 2.5"
  s.add_development_dependency "simplecov", "~> 0.4"
  s.add_development_dependency "autotest", "~> 4.4.6"
  s.add_development_dependency "rspec", "~> 2.6.0"
  s.add_development_dependency "yard"
  s.authors = ['Jim Vallandingham']
  s.description = %q{Stock Search}
  s.email = ''
  s.executables = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  s.extra_rdoc_files = ['LICENSE.textile', 'README.textile']
  s.files = `git ls-files`.split("\n")
  s.homepage = 'http://github.com/vlandham/stocker'
  s.name = 'illuminati'
  s.rdoc_options = ['--charset=UTF-8']
  s.require_paths = ['lib']
  s.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')
  s.summary = s.description
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.version = Stocker::VERSION.dup
end

