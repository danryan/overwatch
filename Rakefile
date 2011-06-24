# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

Overwatch::Application.load_tasks

require 'resque/tasks'

desc "Run watchr"
task :watchr do
  sh %{bundle exec watchr .watchr}
end
