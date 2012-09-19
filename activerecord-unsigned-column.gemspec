# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activerecord-unsigned-column/version'

Gem::Specification.new do |gem|
  gem.name          = "activerecord-unsigned-column"
  gem.version       = ActiveRecord::UnsignedColumn::VERSION
  gem.authors       = ["Ryuta Kamizono"]
  gem.email         = ["kamipo@gmail.com"]
  gem.description   = %q{MySQL's unsigned column support for ActiveRecord}
  gem.summary       = %q{MySQL's unsigned column support for ActiveRecord}
  gem.homepage      = "https://github.com/kamipo/activerecord-unsigned-column"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'rails', ['~> 3.2']
  gem.add_development_dependency 'rspec', ['>= 2.10.0']
  gem.add_development_dependency 'bundler', ['~> 1.2.0']
end
