# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require File.dirname(__FILE__) + "/factories"
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f} 

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include Devise::TestHelpers, :type => :controller

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]  # default, enables both `should` and `expect`
  end
end
