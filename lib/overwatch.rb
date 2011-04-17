require 'yajl'
require 'haml'
require 'sinatra/base'
require 'mongoid'
require 'bson'
require 'mail'

# require 'overwatch/core_ext/object'

require 'overwatch/version'
require 'overwatch/application'

require 'overwatch/models/node'
require 'overwatch/models/snapshot'
require 'overwatch/models/check'
require 'overwatch/models/rule'

require 'overwatch/models/event'
require 'overwatch/models/event/email'
require 'overwatch/models/event/sms'
require 'overwatch/models/event/http'
require 'overwatch/models/event/stdout'

require 'overwatch/routes/node'
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
  end
end
