require 'rubygems'
require 'bundler'
Bundler.setup

require 'resque/server'

$: << File.join(File.dirname(__FILE__), "lib")


require 'overwatch'
Mongoid.logger = Logger.new($stdout)

run Rack::URLMap.new(
  "/"       => Overwatch::Application.new,
  "/resque" => Resque::Server.new

)
