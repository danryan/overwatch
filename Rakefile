require 'bundler'
Bundler::GemHelper.install_tasks


$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib"))
require 'overwatch'

namespace :overwatch do 
  desc "Load up sample data"
  task :data do
    ENV['REDIS_URL'] = "redis://localhost:6379/10"
    Ohm::redis.flushdb
    host1 = Overwatch::Node.create(:name => "host1.example.com")
    host2 = Overwatch::Node.create(:name => "host2.example.com")
    host3 = Overwatch::Node.create(:name => "host3.example.com")
    
    [host1, host2, host3].each do |node|
      data = {
        "memory"=> {
          "dirty"=>"40kB",
          "vmalloc_used"=>"6244kB",
          "page_tables"=>"0kB",
          "buffers"=>"21324kB",
          "slab_unreclaim"=>"7984kB",
          "vmalloc_chunk"=>"34359732100kB",
          "nfs_unstable"=>"0kB",
          "slab"=>"38008kB",
          "inactive"=>"162724kB",
          "total"=>"7864548kB",
          "vmalloc_total"=>"34359738367kB",
          "free"=>"7196552kB",
          "commit_limit"=>"3932272kB",
          "anon_pages"=>"50272kB",
          "writeback"=>"0kB",
          "cached"=>"303556kB",
          "swap"=>{"total"=>"0kB", "free"=>"0kB", "cached"=>"0kB"},
          "committed_as"=>"111888kB",
          "bounce"=>"0kB",
          "slab_reclaimable"=>"30024kB",
          "mapped"=>"10372kB",
          "active"=>"212352kB"
        }
      }
      100.times do
        node.snapshots << Overwatch::Snapshot.create(:data => data, :node => node)
      end
    end  
  end
end