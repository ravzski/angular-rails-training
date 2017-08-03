require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require 'sidekiq/testing'
require 'simplecov'
SimpleCov.start :rails do
  add_group "Models", "app/models"
  add_group "Controllers", "app/controllers"
  add_group "Helpers", "app/helpers"
  add_group "Mailers", "app/mailers"
  add_filter "app/services"
  add_filter "app/mailers/application_mailer.rb"
  add_filter "app/controllers/application_controller.rb"
  add_filter "app/helpers"
  add_filter "app/lib"
end

Sidekiq::Testing.fake! # fake is the default mode
Sidekiq::Testing.inline!
Sidekiq::Testing.disable!

require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
