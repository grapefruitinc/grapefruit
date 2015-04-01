source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'

# Use sqlite3 as the database for tests
# Use mysql2 for development + production
gem 'mysql2'
gem 'connection_ninja'

# Use SCSS for stylesheets
gem 'sass-rails'

gem "compass-rails"
gem "foundation-rails"

# pickadate.js datepicker
gem 'pickadate-rails'

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

# serialize json objects properly
gem "active_model_serializers"

# delayed job for queuing
gem 'delayed_job_active_record'
gem 'daemons'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'

# deployment
gem 'capistrano'
gem 'capistrano-rails'
gem 'capistrano-rvm'
gem 'capistrano3-delayed-job'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# ActiveRecord extensions
gem "activerecord-import", ">= 0.4.0"

# Simple pagination
gem "will_paginate"

# Custom URLs. Read more: https://github.com/norman/friendly_id
gem "friendly_id", ">=5.0.0"

# Active admin for admin panel
gem "activeadmin", github: "gregbell/active_admin"

# react for rails
gem 'react-rails', '~> 1.0.0.pre', github: 'reactjs/react-rails'

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
  gem 'quiet_assets'
end

group :test do
  gem 'sqlite3'
end

# Video Controls
gem 'youtube_it'

group :production do
  gem 'passenger'
  gem 'newrelic_rpm'
end

group :staging do
  gem 'pg'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
