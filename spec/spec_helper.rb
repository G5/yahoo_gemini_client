$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "pry"
require "vcr"
require "rspec/its"

require "dotenv"
Dotenv.load
Dotenv.overload ".env.override"

require "rspec"
require "virtus-matchers"
require "shoulda/matchers"
require "yahoo_gemini_client"

RSpec.configure do |config|
  config.include Virtus::Matchers
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock # or :fakeweb
  config.configure_rspec_metadata!
  [
    "YAHOO_GEMINI_TEST_CONSUMER_KEY",
    "YAHOO_GEMINI_TEST_CONSUMER_SECRET",
    "YAHOO_GEMINI_TEST_AUTHORIZATION_CODE",
  ].each do |env_variable|
    config.filter_sensitive_data("<#{env_variable}>") { ENV[env_variable] }
  end
end
