ENV['RAILS_ENV'] ||= 'test'

require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

Dir[Rails.root.join('spec/support/*.rb')].each { |f| require f }
Dir[Rails.root.join('spec/shared/*.rb')].each { |f| require f }

require 'database_cleaner'

def conn
  ROM::SQL.gateway.connection
end

def clean_db
  DatabaseCleaner[:sequel, connection: conn].clean_with :truncation
end

RSpec.configure do |config|
  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  # Setup database cleaner
  config.before(:suite) do
    DatabaseCleaner[:sequel, connection: conn].strategy = :truncation
    clean_db
  end
  config.before(:each) { clean_db }

  # Include helpers required for all cases
  config.include(AppContainerHelper)
end
