require 'byebug'
require 'capybara/dsl'
require 'capybara/rspec'
require 'pry'
require 'rack/file'
require 'selenium-webdriver'

Selenium::WebDriver.logger.level = :debug

Capybara.app = Rack::File.new(File.dirname(__FILE__))

Capybara.configure do |config|
  config.server = :webrick
  config.default_driver = :selenium_headless
  config.javascript_driver = :selenium_headless
  config.default_max_wait_time = 5
end

RSpec.configure do |config|
  config.include Capybara::DSL

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random
end
