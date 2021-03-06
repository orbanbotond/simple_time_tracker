source 'https://rubygems.org'
ruby '2.2.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use sqlite3 as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'bootstrap-sass', '~> 3.3.3'
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'active_attr'
gem 'display_case'
gem 'squeel'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'devise', '~> 3.4'
gem 'email_validator'
gem 'slim', '~> 2.0'
gem 'inherited_resources', '~> 1.6'
gem 'pundit'

gem 'pry'
gem 'pry-nav'
gem 'simple_form', '~> 3.1'

gem 'grape', '~> 0.11'
gem 'grape-entity', '~> 0.4.5'
gem 'grape-swagger', '~> 0.10'
gem 'grape-swagger-ui', '~> 0.0.9'
gem 'rolify', '~> 4.0'
gem 'will_paginate', '~> 3.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
  gem 'quiet_assets'
  gem 'spring-commands-rspec'
  gem 'rails_layout'
  gem 'better_errors'
end

group :development, :test do
  gem 'ffaker'
  gem 'rspec-rails', '~> 3.2'
  gem 'factory_girl_rails', '~> 4.5'
  gem 'database_cleaner', '~> 1.4'
  gem 'capybara', '~> 2.4'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'guard', '~> 2.2'
  gem 'guard-rspec',  '~> 4.5'
  gem 'guard-bundler', '~> 2.1'
  gem 'guard-livereload', '~> 2.4'
  gem 'guard-migrate'

  gem 'grape-entity-matchers', '~> 1.0'
end

group :test do
  gem 'shoulda-matchers', require: false
  gem 'simplecov', require: false
end

group :production do
  gem 'rails_12factor'
  # gem 'postmark-rails'
end
