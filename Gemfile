source "https://rubygems.org"

ruby "~> 3.3" # If this changes, change .ruby-version and Dockerfile, too

gem "rails", "~> 7.2"
gem "propshaft"
gem "sqlite3", "~> 1.4"
gem "puma", ">= 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem "bootsnap", require: false
gem "hac_adapter", "1.3.0", git: "https://github.com/dotnofoolin/hac_adapter.git"
gem "rufus-scheduler"
gem "thruster"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
end

group :development do
  gem "web-console"
  gem "kamal"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "simplecov"
  gem "faker"
  gem "webmock"
  gem "vcr"
end
