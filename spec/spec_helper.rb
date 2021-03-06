require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = true
    
    # Needed for Spork
    ActiveSupport::Dependencies.clear
  end
  
  def test_sign_in(user)
    controller.sign_in(user)
  end
end

Spork.each_run do
  require 'factory_girl_rails'
  load "#{Rails.root}/config/routes.rb"
  Dir["#{Rails.root}/app/**/*.rb"].each { |f| load f }

  # Load the sessions_helper extension to the application_controller 
  # for each run to so Spork doesn't have to be reloaded after a change
  # to the sessions_helper
#  def test_sign_in(user)
#    controller.sign_in(user)
#  end
end

