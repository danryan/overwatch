module Overwatch
  class Snapshot
    include Mongoid::Document
    include Mongoid::Timestamps::Created
    
    attr_accessor :raw_data
    # field :raw_data, :type => String
    referenced_in :resource, :class_name => "Overwatch::Resource"
    
    before_save :parse_data
    after_save :run_checks

    def parse_data
      Overwatch.redis.set "snapshots:#{self._id}:data", Yajl.dump(self.raw_data)
    end
    
    def data
      Hashie::Mash.new(Yajl.load(Overwatch.redis.get "snapshots:#{self._id}:data"))
    end
    
    def run_checks
      self.resource.run_checks
    end
  end # class Snapshot 
end # module Overwatch