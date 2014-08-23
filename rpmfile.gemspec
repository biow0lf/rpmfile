# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rpmfile/version'

Gem::Specification.new do |spec|
  spec.name          = 'rpmfile'
  spec.version       = RPM::File::VERSION
  spec.authors       = ['Igor Zubkov']
  spec.email         = ['igor.zubkov@gmail.com']
  spec.summary       = %q{Read rpm file info via rpm binary.}
  spec.description   = %q{Read rpm file info via rpm binary.}
  spec.homepage      = 'https://github.com/biow0lf/rpmfile'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'childprocess', '~> 0.5.3'
  spec.add_development_dependency 'rspec', '~> 3.0.0'
  spec.add_development_dependency 'simplecov', '~> 0.9.0'
end
