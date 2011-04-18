module Overwatch
  class CheckRun
    @queue = :checks
    
    def self.perform(node_id)
      node = Node.find(node_id)
      node.checks.each do |check|
        check.run(node.last_update)
      end
    end
  end
end