# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "Object Orientated Game"
  spec.version       = '1.0'
  spec.authors       = ["Jonathon Yamada"]
  spec.email         = ["jonathon.yamada@gmail.com"]
  spec.summary       = %q{Simple turn based battle game}
  spec.description   = %q{This is a simple game used for demonstration purposes of my OOP understanding}
  spec.homepage      = "N/A"
  spec.license       = "MIT"

  spec.files         = ['lib/object_orientated_game']
  spec.executables   = ['bin/object_orientated_game']
  # spec.test_files    = ['tests/test_NAME.rb']
  spec.require_paths = ["lib"]
end