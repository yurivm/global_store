# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'global_store/version'

Gem::Specification.new do |spec|
  spec.name          = "global_store"
  spec.version       = GlobalStore::VERSION
  spec.authors       = ["Yuri Veremeyenko"]
  spec.email         = ["yuri.veremeyenko@gmail.com"]
  spec.summary       = %q{A wrapper over request_store to store global data on the app level without messing with Thread.current .}
  spec.description   = %q{This gem is just a quick wrapper over request_store that allows you to get and set varibles that are supposed to be global in the scope of your request processing. You can use any store that impelements get() and set() but having request_store is nice since it ensures all the keys/values you've set are cleared after the request has been processed}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'request_store'
  
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
