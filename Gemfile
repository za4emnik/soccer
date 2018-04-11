source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'aasm'
gem 'acts_as_list'
gem 'bootstrap-sass'
gem 'cancancan'
gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'dotenv-rails'
gem 'fog-aws'
gem 'friendly_id', '~> 5.1.0'
gem 'haml'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'mini_magick'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'pg'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.5'
gem 'rectify'
gem 'require_all'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'factory_bot_rails'
  gem 'pry'
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'rubocop', '~> 0.49.1', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console'
end

group :test do
  gem 'database_cleaner'
  gem 'ffaker'
  gem 'rails-controller-testing'
  gem 'rspec-html-matchers'
  gem 'shoulda-matchers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
