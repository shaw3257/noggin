# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'noggin/version'

Gem::Specification.new do |spec|
  spec.name          = 'the_noggin'
  spec.version       = Noggin::VERSION
  spec.authors       = ['Shawn']
  spec.email         = ['shaw3257@gmail.com']
  spec.description   = 'Ruby Neural Network implementation using backpropagation and gradient descent for training'
  spec.summary       = 'Pass in training samples, and the network will try to find pathways that lead to the least amount of error. The network is customizable in that it let’s you control the learning rate, hidden layer size and depth, and max training iterations.'
  spec.homepage      = 'https://github.com/shaw3257/noggin'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 10.4'
  spec.add_development_dependency 'rspec', '~> 3.2'
end
