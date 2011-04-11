require 'rubygems'

$: << File.join(File.dirname(__FILE__), "lib")

require 'overwatch'
run Overwatch::Application.new