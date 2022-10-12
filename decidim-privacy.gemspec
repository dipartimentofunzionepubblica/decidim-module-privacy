# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require "decidim/privacy/version"

Gem::Specification.new do |s|
  s.version = Decidim::Privacy.version
  s.authors = ["Lorenzo Angelone"]
  s.email = ["l.angelone@kapusons.it"]
  s.license = "AGPL-3.0"
  s.homepage = "https://github.com/decidim/decidim-module-privacy"
  s.required_ruby_version = ">= 2.7"

  s.name = "decidim-privacy"
  s.summary = "A decidim privacy module"
  s.description = "The component adds the ability to configure the ability to improve the privacy of user data at the organization or individual user level.."

  s.files = Dir["{app,config,lib}/**/*", "LICENSE-AGPLv3.txt", "Rakefile", "README.md"]

  s.add_dependency "decidim-core", Decidim::Privacy.version
  s.add_dependency "decidim-admin", Decidim::Privacy.version
  s.add_dependency "deface", '1.9.0'
end
