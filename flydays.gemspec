# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "flydays"
  spec.version       = "0.1.0"
  spec.authors       = ["Evan R"]
  spec.email         = ["eunoia.github+flydays@gmail.com"]

  spec.summary       = %q{Search flights on Southwest.}
  spec.homepage      = "https://github.com/Eunoia/flydays"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'guard', '~> 2.13'
  spec.add_development_dependency 'guard-rspec', '~> 4.6'
  spec.add_development_dependency 'rspec', '~> 3.4'
  spec.add_development_dependency 'rspec-nc', '~> 0.2'
  spec.add_development_dependency 'vcr', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 1.21'
  spec.add_development_dependency 'timecop', '~> 0.8'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'pry-stack_explorer', '~> 0.4'
  spec.add_development_dependency 'awesome_print', '~> 1.6'
  spec.add_development_dependency 'simplecov', '~> 0.11'

  spec.add_runtime_dependency "mechanize", "~>2.7"

end
