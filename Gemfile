source 'https://rubygems.org'

gem 'rails'

gem 'httparty'
#for parsing rss feeds
  gem 'feedzirra'
gem 'figaro'

gem 'omniauth-twitter'
gem 'twitter'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
group :development do
  gem 'sqlite3'
end

group :test do
  gem 'mocha', require: false
  gem 'capybara'
  gem 'shoulda'
end

group :test, :development do
	gem "factory_girl_rails"
	gem 'faker'
end

group :production do
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'angularjs-rails'
  gem 'sass-rails'
  gem 'less-rails'
  gem 'twitter-bootstrap-rails'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer'
  gem 'uglifier'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'