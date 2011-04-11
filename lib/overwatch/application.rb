require 'overwatch/helpers'
require 'overwatch/routes/node'
require 'overwatch/routes/snapshot'

module Overwatch
  class Application < Sinatra::Base
    helpers Overwatch::Helpers
    
    configure do
      set :app_file, __FILE__
      set :logging, true
      set :run, false
      set :redis_url, ENV['REDIS_URL'] || 'redis://localhost:6379/0'
      set :show_exceptions, false
      set :server, %w[thin mongrel webrick]
      set :raise_errors, false
    end
    
    configure(:development) do
      begin
        require 'sinatra/reloader'
        register Sinatra::Reloader
        also_reload File.join(File.dirname(__FILE__), 'overwatch/models/node')
        also_reload File.join(File.dirname(__FILE__), 'overwatch/models/snapshot')
        also_reload File.join(File.dirname(__FILE__), 'overwatch/routes/node')
        also_reload File.join(File.dirname(__FILE__), 'overwatch/routes/snapshot')
        also_reload File.join(File.dirname(__FILE__), 'overwatch/helpers')
      rescue LoadError
        puts "sinatra-reloader gem missing. reloading disabled"
      end
    end
    
    before do
      content_type "application/json"
    end
    
  end
end