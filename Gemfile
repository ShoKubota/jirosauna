source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Assets
gem 'font-awesome-rails'
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Model
gem 'enum_help'

# Authentication
gem 'sorcery'

# Localization
gem 'rails-i18n'

# UI/UX
gem 'slim-rails'
gem 'html2slim'
gem 'draper'

# Scraping
gem 'nokogiri'

# Redirection
gem 'open_uri_redirections'

#Security
gem 'dotenv-rails'

# Geolocation
gem 'geokit-rails'

# Normalize phone number
gem 'phony_rails'

# JavaScript
gem 'gon'

# Pagination
gem 'kaminari'

# Search
gem 'ransack'

# ActiveRecord
gem 'activerecord-import'

# admin
gem 'rails_admin', ['>= 3.0.0.beta2', '< 4']

# SEO
gem 'meta-tags'

# Shorten URL
gem 'shortener'

# Image upload
gem 'carrierwave', '~> 2.0'
gem "mini_magick"

gem 'rexml', '~> 3.2', '>= 3.2.5'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  #Debugger
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry-rails'

  # Test
  gem 'factory_bot_rails'
  gem 'rspec-rails'

  # Code analyse
  gem 'rubocop', require:false
  gem 'rubocop-rails', require:false
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
end

group :test do
  gem 'capybara'
  gem 'faker'
  gem 'fuubar'
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
