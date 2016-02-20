source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.0'
# Use sqlite3 as the database for Active Record
#gem 'sqlite3', group: [:development, :test]
# Use mysql for production
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# I18n
gem 'rails-i18n', '~> 4.0.0' # For 4.0.x

# User management
gem 'devise', '~> 3.5.2'
gem 'devise-i18n'

# scope
gem 'has_scope'

# Model pagination
gem 'kaminari', '~> 0.16.1'

# Record Versioning
gem 'paper_trail', '~> 4.0.0'

# Use Bootstrap for stylesheets
gem 'bootstrap-sass', '~> 3.3.4'

# Use slim to simplify html code
gem 'slim', '~> 3.0.6'
gem 'slim-rails'

# Official Font Awesome SASS Ruby Gem
gem 'font-awesome-sass'

# Messenger javascript library
gem 'messengerjs-rails', '~> 1.4.1'
gem 'selectize-rails'

# JSON validator
gem 'activerecord_json_validator'
gem 'json-schema', '2.5.2'

# Use puma server
gem 'puma'

# A higher level command-line oriented interface
gem 'highline'

# Queue processing
gem 'sidekiq'
gem 'devise-async'

# Traffic throttling
gem 'rack-attack'

# Hash lib
gem 'easy_diff'

# Error handling
gem 'rambulance'

# Redis
gem 'redis'
gem 'redis-namespace'
gem 'redis-rails'
gem 'redis-rack-cache'

# JSON lib
gem 'oj'
gem 'oj_mimic_json'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  # N+1 problem
  gem 'bullet'
  # Deployment
  gem 'capistrano-rails'
  # console
  gem 'pry-rails'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails', '~> 4.0', require: false
  gem 'shoulda-matchers'
  gem 'shoulda-callback-matchers', '~> 1.1.1'
  #gem 'rack-mini-profiler'
  gem 'database_cleaner'
  gem "codeclimate-test-reporter", require: nil
  gem 'simplecov', require: false
end

source 'https://rails-assets.org' do
  gem 'rails-assets-autosize'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use debugger
# gem 'debugger', group: [:development, :test]
