# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'apartment_cli_gem/version'

Gem::Specification.new do |spec|
  spec.name          = "apartment_search"
  spec.version       = ApartmentCliGem::VERSION
  spec.authors       = ["Christopher Bruen"]
  spec.email         = ["bruen.chris@gmail.com"]
  spec.require_paths = ["lib", "lib/apartment_cli_gem"]
  spec.summary       = %q{Lets you scroll through Craigslist room share listings for select cities.}

  spec.homepage      = "https://rubygems.org/gems/apartment_search"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://rubygems.org'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ["apartment_search"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "nokogiri"
end
