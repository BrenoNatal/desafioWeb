ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    include Devise::Test::IntegrationHelpers
    # Devise.mappings[:account] = Devise.mappings[:default] if Devise.mappings[:account].nil?
    ActiveSupport.on_load(:action_mailer) do
      Rails.application.reload_routes_unless_loaded
    end
  end
end
