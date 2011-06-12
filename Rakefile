require 'bundler'
Bundler::GemHelper.install_tasks

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib"))
require 'overwatch'
require 'resque'
require 'resque/tasks'

namespace :db do
  desc "Load up sample data"
  task :seed do
    require 'yaml'
    DATA = YAML.load_file(File.join(File.dirname(__FILE__), "spec/support/data.yml"))

    Mongoid.master.collections.select do |collection|
      collection.drop unless collection.name =~ /(system|local)/
    end
    host1 = Overwatch::Resource.create(:name => "host1.example.com")
    host2 = Overwatch::Resource.create(:name => "host2.example.com")
    host3 = Overwatch::Resource.create(:name => "host3.example.com")

    resources = [host1, host2, host3]
    
    check1 = Overwatch::Check.create
    check2 = Overwatch::Check.create
    check3 = Overwatch::Check.create

    checks = [ check1, check2, check3 ]
    checks.each do |check|
      check.rules << Overwatch::Rule.if("redis.version").is("2.2.2")
      check.rules << Overwatch::Rule.if("mongo.version").less_than("1.9.0")

      resources.each do |resource|
        check.resources << resource
        resource.checks << check
      end
    end
    
    resources.each do |resource|
      100.times do
        puts "Adding snapshot"
        resource.snapshots << Overwatch::Snapshot.create(:raw_data => DATA, :resource => resource)
      end
    end  

    # introduce failure
    check1.rules << Overwatch::Rule.create(:attr => "redis.version").greater_than("2.2.4")

    # And now for some events!
    check1.events << Overwatch::Event::Email.create(:recipients => ["scriptfu@gmail.com"])

  end

  desc "Load up sample data"
  task :superseed do
    require 'yaml'
    require 'benchmark'
    DATA = YAML.load_file(File.join(File.dirname(__FILE__), "spec/support/data.yml"))

    Benchmark.bm do |bench|
      bench.report("reset") do
        Mongoid.master.collections.select do |collection|
          collection.drop unless collection.name =~ /(system|local)/
        end
      end

      bench.report("resources") do
        @host1 = Overwatch::Resource.create(:name => "host1.example.com")
        @host2 = Overwatch::Resource.create(:name => "host2.example.com")
        @host3 = Overwatch::Resource.create(:name => "host3.example.com")
      end
      
      resources = [@host1, @host2, @host3]

      bench.report("checks") do
        @check1 = Overwatch::Check.create
        @check2 = Overwatch::Check.create
        @check3 = Overwatch::Check.create

        checks = [ @check1, @check2, @check3 ]
        checks.each do |check|
          check.rules << Overwatch::Rule.if("redis.version").is("2.2.2")
          check.rules << Overwatch::Rule.if("mongo.version").less_than("1.9.0")

          resources.each do |resource|
            check.resources << resource
            resource.checks << check
          end
        end
      end
      # introduce failure
      # check1.rules << Overwatch::Rule.create(:attr => "redis.version").greater_than("2.2.4")

      # And now for some events!
      @check1.events << Overwatch::Event::Email.create(:recipients => ["scriptfu@gmail.com"])
      
      resources.each do |resource|
        bench.report("snapshots for #{resource.name}") do
          100.times do
            resource.snapshots << Overwatch::Snapshot.create(:raw_data => DATA, :resource => resource)
          end
        end
      end  



    end
  end
end

