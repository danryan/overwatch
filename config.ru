require 'rubygems'
require 'bundler'
Bundler.setup

require 'resque/server'

$: << File.join(File.dirname(__FILE__), "lib")

require 'overwatch'
run Rack::URLMap.new(
  "/"       => Overwatch::Application.new,
  "/resque" => Resque::Server.new

)
