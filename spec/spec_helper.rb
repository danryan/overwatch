require 'rubygems'
require 'spork'

Spork.prefork do 
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  # require 'shoulda/action_controller'
  # require 'shoulda/rspec'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  ENV['REDIS_URL'] = 'redis://localhost:6379/3'

  RSpec.configure do |config|
    config.color_enabled = true
    config.formatter = "documentation"
    config.mock_with :rspec
    
    config.before :suite do
      $redis.flushdb
    end
  end
end

Spork.each_run do
end