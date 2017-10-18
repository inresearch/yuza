# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!
#
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

def user_attributes
  {
    name: 'Adam',
    email: 'adam@netinmax.com'
  }
end

def password_attributes
  {
    app: 'pageok',
    password: 'Password01'
  }
end

def build_user
  User.new(user_attributes)
end

def create_user
  u = build_user; u.save!; u
end

def create_password(u, attributes={})
  u.init_new_password(attributes).save!
end

def create_session(u, app='pageok')
  s = Session.new(
    user: u,
    app: app,
    expiry_time: 30.minutes.from_now,
    ip: '127.0.0.1'
  )
  s.save!
  s
end

def parsed_body
  JSON.parse(response.body).deep_symbolize_keys
end
