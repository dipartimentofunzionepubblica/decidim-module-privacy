# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

DECIDIM_VERSION = "~> 0.28.5"

gem "decidim", DECIDIM_VERSION
gem "decidim-privacy", path: "."

gem "puma", ">= 6.3.1"
gem "uglifier", "~> 4.1"
gem "bootsnap"
# gem "doorkeeper", "~> 5.5.1"

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri

  gem "decidim-dev", DECIDIM_VERSION
  gem "rspec-rails", '~> 6.0'
  gem 'shoulda-matchers', '~> 6.0'
end

group :development do
  gem "faker", "~> 3.2"
  gem "letter_opener_web", "~> 2.0"
  gem "listen", "~> 3.1"
  gem "spring", "~> 2.0"
  gem "spring-watcher-listen", "~> 2.0"
  gem "sqlite3"
  gem "web-console", "~> 4.2"
end

