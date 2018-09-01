source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.1'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3', group: [:development, :test]
# Use postgresql for production
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.2.2'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
# gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# I18n
gem 'rails-i18n', '~> 5.1' # For 5.x

# User management
gem 'devise', '~> 4.5.0'

# scope
gem 'has_scope'

# Model pagination
gem 'kaminari', '~> 1.1.1'

# Record Versioning
gem 'paper_trail', '~> 9.2.0'

# Use Bootstrap for stylesheets
gem 'bootstrap-sass', '~> 3.3.4'

# Use slim to simplify html code
gem 'slim', '~> 3.0.6'
gem 'slim-rails'

# Official Font Awesome SASS Ruby Gem
gem 'font-awesome-sass', '~> 4'

# Messenger javascript library
gem 'messengerjs-rails', '~> 1.4.1'

# Inline editing
gem 'bootstrap-editable-rails'

# JSON validator
gem 'activerecord_json_validator'
gem 'json-schema'

# Use puma server
gem 'puma'

# A higher level command-line oriented interface
gem 'highline'

# Queue processing
gem 'sidekiq'

# Traffic throttling
gem 'rack-attack'

# Hash lib
gem 'easy_diff'

# Error handling
gem 'rambulance'

# Redis
gem 'hiredis'
gem 'redis'
gem 'redis-rails'

# JSON lib
gem 'oj'
gem 'oj_mimic_json'

# Console
gem 'pry-rails'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  # N+1 problem
  gem 'bullet'
end

group :development, :test do
  gem 'capybara'
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_bot_rails', '~> 4.0', require: false
  gem 'shoulda-matchers'
  gem 'shoulda-callback-matchers', '~> 1.1.1'
  #gem 'rack-mini-profiler'
  gem 'brakeman', require: false
  gem 'rails_best_practices', require: false
  gem 'rubycritic', require: false
  gem 'database_cleaner'
  gem "codeclimate-test-reporter", require: nil
  gem 'simplecov', require: false
  gem 'rails-controller-testing'
end

source 'https://rails-assets.org' do
  gem 'rails-assets-autosize'
end

