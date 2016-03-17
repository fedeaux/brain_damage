source 'https://rubygems.org'

gem 'rails', '4.2.3'

# Database
gem 'pg'
gem 'schema_plus'

# Utility
gem 'string-urlize'
gem "seedbank"

# CSS Framework
gem 'therubyracer'
gem 'less-rails-semantic_ui'

# Frontend
gem 'sass-rails', '~> 5.0'
gem 'compass-rails'
gem 'haml-rails'
gem 'best_in_place', github: 'aaronchi/best_in_place'
gem 'high_voltage'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'underscore-rails'
gem 'momentjs-rails'
gem 'turbolinks'

# REST
gem 'gon'
gem 'rabl'
gem 'httparty'
gem 'httmultiparty'

gem 'sdoc', '~> 0.4.0', group: :doc

# Console
gem "table_print"
gem "awesome_print"
gem "text-table"
gem "pry"

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', '~> 0.7.2'
  gem 'quiet_assets'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'capybara'
  gem "capybara-webkit"
  gem 'capybara-screenshot'
  gem 'database_cleaner', :git => 'git://github.com/bmabey/database_cleaner.git'
  gem 'email_spec'
end

group :test do
  gem 'factory_girl_rails'
  gem "rspec-rails"
end

group :production do
  gem 'rails_12factor' # Using heroku ?
end
