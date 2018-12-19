ENV['RAILS_ENV'] ||= 'test'

require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

Dir[Rails.root.join('spec/support/*.rb')].each { |f| require f }
Dir[Rails.root.join('spec/shared/*.rb')].each { |f| require f }

require 'database_cleaner'

def container
  AppContainer.instance
end

def connection
  container['persistence'].gateways[:utm].connection
end

def clean_strategy
  target_databases = %w[
    discount_transactions_all
    services_data
    payment_transactions
    payment_methods
    tariffs_services_link
    tariffs
  ]
  [:truncation, { only: target_databases }]
end

def clean_db
  DatabaseCleaner[:sequel, connection: connection].clean_with *clean_strategy
end

RSpec.configure do |config|
  # Include factory bot helpers
  config.include FactoryBot::Syntax::Methods

  # Include helpers required for all cases
  config.include(AppContainerHelper)

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  # Setup database cleaner
  config.before(:suite) do
    DatabaseCleaner[:sequel, connection: connection].strategy = *clean_strategy
    clean_db
  end
  config.before(:each) { clean_db }
end
