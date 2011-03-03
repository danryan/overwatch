#!/usr/bin/env ruby

require 'rubygems'
require 'json'

def run
  regex = Regexp.new(/load averages?: ([\d.]+),? ([\d.]+),? ([\d.]+)\Z/)
  avg = regex.match(%x[ uptime ]).captures

  metric = {}
  metric[:metric] = {}
  metric[:metric][:data] = { :one_min => avg[0], :five_min => avg[1], :fifteen_min => avg[2] }
  metric[:metric][:name] = "load average"
  return metric 
end

# puts run
# puts run[:metric][:data][:one_min].class
puts run.to_json

