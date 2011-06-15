require 'overwatch/helpers'
require 'overwatch/routes/resource'
require 'overwatch/routes/snapshot'
require 'overwatch/routes/check'

module Overwatch
  class Application < Sinatra::Base
    helpers Overwatch::Helpers
    
    configure do
      set :app_file, __FILE__
      set :logging, true
      set :run, false
      set :show_exceptions, false
      set :server, %w[ thin mongrel webrick ]
      set :raise_errors, false
    end
    
    configure(:development) do
      begin
        require 'sinatra/reloader'
        register Sinatra::Reloader
        also_reload File.join(File.dirname(__FILE__), 'resource')
        also_reload File.join(File.dirname(__FILE__), 'snapshot')
        also_reload File.join(File.dirname(__FILE__), 'routes/resource')
        also_reload File.join(File.dirname(__FILE__), 'snapshot')
        also_reload File.join(File.dirname(__FILE__), 'helpers')
      rescue LoadError
        puts "sinatra-reloader gem missing. reloading disabled"
      end
      # Mongoid.configure do |config|
      #   config.master = Mongo::Connection.new.db("overwatch_dev")
      #   config.persist_in_safe_mode = false
      # end  
      
    end
    configure(:production) do
      # Mongoid.configure do |config|
      #   config.master = Mongo::Connection.new.db("overwatch_production")
      #   config.persist_in_safe_mode = false
      # end  
    end
    
    before do
      content_type "application/json"
    end
    
  end
end