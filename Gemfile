source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.1'

# Use sqlite3 as the database for testss
# Use mysql2 for development + production
gem 'sqlite3'
gem 'mysql2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# ZURB Foundation 4.0
gem "compass-rails"
gem 'zurb-foundation'

# config for configuraiton files and YAML
gem 'rails_config'

# devise for authentication
gem 'devise'

# cancan for permissions
gem 'cancan'

# carrierwave for file uploads
gem 'carrierwave'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# ActiveRecord extensions
gem "activerecord-import", ">= 0.4.0"

# Simple pagination
gem "will_paginate"

# Video Controls
gem 'youtube_it'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  # helpful if you know you won't have an internet connection
  gem 'sdoc', require: false
end

# Test
group :test, :development do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'shoulda-matchers'
end

group :development do
  gem 'annotate'
  gem 'thin'
  # optional, makes git deployment easy.
  # gem 'git-deploy'
end

group :production do
  gem 'passenger'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
