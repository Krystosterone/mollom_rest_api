lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mollom_rest_api/version'

Gem::Specification.new do |spec|
  spec.name          = "mollom_rest_api"
  spec.version       = MollomRestApi::VERSION
  spec.authors       = ["Jean-Sébastien Roy", "Krystian Czesak"]
  spec.email         = ["mollom.gem@gmail.com"]
  spec.description   = %q{A ruby wrapper for the Mollom Rest API.}
  spec.summary       = %q{A ruby wrapper for the Mollom Rest API.}
  spec.homepage      = ""
  spec.license       = ""

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'oauth'
  spec.add_dependency 'activesupport'
end
