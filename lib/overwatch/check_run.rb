module Overwatch
  class CheckRun
    @queue = :checks
    
    def self.perform(resource_id)
      resource = Resource.find(resource_id)
      resource.checks.each do |check|
        check.run(resource.last_update)
      end
    end
  end
end