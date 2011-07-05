# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

Overwatch::Application.load_tasks

require 'resque/tasks'
require 'resque_scheduler/tasks'    


desc "Run watchr"
task :watchr do
  sh %{bundle exec watchr .watchr}
end


namespace :resque do
  task :setup do
    require 'resque'
    require 'resque_scheduler'
    require 'resque/scheduler'
    
    Resque.redis = 'localhost:6379'
    
    Resque.schedule = YAML.load_file(
      File.join(File.expand_path(File.dirname(__FILE__)), 'config/schedule.yml')
    )
  
  end
end    

namespace :overwatch do
  namespace :test do 
    task :snapshot => :environment do
      a = Asset.first
      a.snapshots.create(:raw_data => {:one => rand(10), :two => { :three => rand(10) }})
    end
  end
end