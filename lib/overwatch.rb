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
end
