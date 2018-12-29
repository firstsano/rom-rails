source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

gem 'blueprinter'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'dry-auto_inject'
gem 'dry-validation'
gem 'exception_notification'
gem 'figaro'
gem 'knock'
gem 'pg'
gem 'puma', '~> 3.11'
gem 'rack-cors'
gem 'rails', '~> 5.2.1'
gem 'recursive-open-struct'
gem 'responders'
gem 'rom-http'
gem 'rom-rails'
gem 'rom-repository'
gem 'rom-sql'
gem 'sanitize'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'versionist'

group :development do
  gem 'capistrano', '~> 3.10', require: false
  gem 'capistrano-bundler'
  gem 'capistrano-passenger'
  gem 'capistrano-rails', '~> 1.4', require: false
  gem 'capistrano-rvm'
  gem 'capistrano-touch-linked-files'
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', '~> 0.60.0', require: false
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails', '~> 3.8'
end
