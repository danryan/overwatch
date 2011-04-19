require 'bundler'
Bundler::GemHelper.install_tasks

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib"))
require 'overwatch'
require 'resque'
require 'resque/tasks'

namespace :overwatch do 
  desc "Load up sample data"
  task :data do
    require 'yaml'
    DATA = YAML.load_file(File.join(File.dirname(__FILE__), "spec/support/data.yml"))
    
    Mongoid.master.collections.select do |collection|
      collection.drop unless collection.name =~ /(system|local)/
    end
    host1 = Overwatch::Node.create(:name => "host1.example.com")
    host2 = Overwatch::Node.create(:name => "host2.example.com")
    host3 = Overwatch::Node.create(:name => "host3.example.com")
    
    nodes = [host1, host2, host3]
    nodes.each do |node|
      10.times do
        puts "Adding snapshot"
        node.snapshots << Overwatch::Snapshot.create(DATA)
      end
    end  
    check1 = Overwatch::Check.create
    check2 = Overwatch::Check.create
    check3 = Overwatch::Check.create
    
    checks = [ check1, check2, check3 ]
    checks.each do |check|
      check.rules << Overwatch::Rule.if("redis.version").is("2.2.2")
      check.rules << Overwatch::Rule.if("mongo.version").less_than("1.9.0")
      
      nodes.each do |node|
        check.nodes << node
        node.checks << check
      end
    end
    
    # introduce failure
    check1.rules << Overwatch::Rule.create(:attr => "redis.version").greater_than("2.2.4")
  end
end

