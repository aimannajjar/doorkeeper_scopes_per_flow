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
  s.summary     = "TODO: Summary of DoorkeeperScopesPerFlow."
  s.description = "TODO: Description of DoorkeeperScopesPerFlow."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.6"

  s.add_development_dependency "sqlite3"
end
