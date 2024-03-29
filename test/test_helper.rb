ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "simplecov"

SimpleCov.start do
  add_filter "/test/"
  add_filter "/config/"
end

VCR.configure do |c|
  c.ignore_localhost = true
  c.cassette_library_dir = './test/cassettes'
  c.hook_into :webmock
end

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
