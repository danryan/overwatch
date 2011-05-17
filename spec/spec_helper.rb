require 'rubygems'
require 'spork'

Spork.prefork do 
  $: << File.join(File.dirname(__FILE__), "../lib")
  require 'overwatch'
  require 'rspec'

  Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each { |f| require f }
  
  RSpec.configure do |config|
    config.color_enabled = true
    config.formatter = "documentation"
    
    config.before(:each) do
    end
    
    config.before(:suite) do
    end
  end
end

Spork.each_run do
  
end