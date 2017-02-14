$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "doorkeeper_scopes_per_flow/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "doorkeeper_scopes_per_flow"
  s.version     = DoorkeeperScopesPerFlow::VERSION
  s.authors     = ["Aiman Najjar"]
  s.email       = ["aiman.najjar@hurranet.com"]
  s.homepage    = "http://github.com/aiman86/doorkeeper_scopes_per_flow"
  s.summary     = "Doorkeeper extension to set allowed/default scopes for each grant_type (flow)"
  s.description = "Doorkeeper extension to limit scopes available per flow/grant_type and specify a default one for each flow"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4"
  s.add_dependency 'doorkeeper', '>= 3.1'
  s.add_dependency 'activesupport-decorators', '~> 2.1'
end
