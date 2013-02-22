# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'multirb/version'

Gem::Specification.new do |gem|
  gem.name          = "multirb"
  gem.version       = Multirb::VERSION
  gem.authors       = ["Peter Cooper"]
  gem.email         = ["git@peterc.org"]
  gem.description   = %{Run Ruby code over multiple implementations/versions using RVM or RBENV from a IRB-esque prompt}
  gem.summary       = %{Run Ruby code over multiple implementations/versions using RVM or RBENV from a IRB-esque prompt}
  gem.homepage      = "https://github.com/peterc/multirb"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
