if ENV['COVERAGE']
  require 'simplecov'
  require 'build_failure_formatter'
  SimpleCov.formatter = BuildFailureFormatter
  SimpleCov.start 'rails' do
    coverage_dir 'tmp/coverage'
    add_filter '/vendor/'
  end
end

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

FactoryGirl.find_definitions

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :mocha

  config.use_transactional_fixtures = true

  config.render_views

  config.include ActiveSupport::Testing::Assertions
  config.include TwilioMatchers
end
