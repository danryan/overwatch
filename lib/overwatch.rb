require 'yajl'
require 'haml'
require 'sinatra/base'
require 'redis'
require 'ohm'
require 'ohm/contrib'
require 'mail'
require 'hashie'
require 'rest-client'
require 'active_support'

require 'overwatch/version'
require 'overwatch/application'

require 'overwatch/resource'
require 'overwatch/snapshot'
require 'overwatch/check'
require 'overwatch/resource_check'
require 'overwatch/rule'
require 'overwatch/check_run'
require 'overwatch/check_event'
require 'overwatch/event'
require 'overwatch/event/email'
require 'overwatch/event/sms'
require 'overwatch/event/http'
require 'overwatch/event/stdout'
require 'overwatch/event/xmpp'

require 'overwatch/routes/resource'
require 'overwatch/routes/snapshot'

module Overwatch
  class << self
    def config_file_path
      @config_file_path ||= 
        File.expand_path(File.join(File.dirname(__FILE__), "../config/overwatch.yml"))
    end
      
    def config
      @config ||= YAML.load_file(config_file_path)
    end
    
    def redis
      @redis = Redis.new
    end
  end
end
