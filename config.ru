# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'
ROM.env.gateways[:utm].disconnect

run Rails.application
