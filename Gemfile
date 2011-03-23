source 'http://rubygems.org'

gem 'rails', '3.0.5'
gem 'sqlite3'
gem 'sqlite3-ruby', :require => 'sqlite3'
gem 'gravatar_image_tag'

group :development do
  gem 'rspec-rails'
  gem 'annotate-models'
end
  
group :test do
  gem 'watchr'
  gem 'spork'
  gem 'webrat', '0.7.1'
  gem 'factory_girl_rails', :require => false
  # I had to install FG 1.0.1 manually: $gem install factory_girl_rails
  # In spec_helper, added to Spork.each_run do block: require 'factory_girl_rails'
end

