# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require "decidim/privacy/version"

Gem::Specification.new do |s|
  s.version = Decidim::Privacy.version
  s.authors = ["Lorenzo Angelone"]
  s.email = ["l.angelone@kapusons.it"]
  s.license = "AGPL-3.0"
  s.homepage = "https://github.com/dipartimentofunzionepubblica/decidim-module-privacy"
  s.required_ruby_version = ">= 3.1"

  s.name = "decidim-privacy"
  s.summary = "A decidim privacy module"
  s.description = "The component adds the ability to configure the ability to improve the privacy of user data at the organization or individual user level.."

  s.files = Dir["{app,config,lib}/**/*", "LICENSE-AGPLv3.txt", "Rakefile", "README.md"]

  s.add_dependency "decidim-core", ">= 0.28.x", "< 0.29.x"
  s.add_dependency "decidim-admin", ">= 0.28.x", "< 0.29.x"
  s.add_dependency "deface", '1.9.0'
end
