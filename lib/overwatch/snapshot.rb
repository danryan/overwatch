module Overwatch
  class Snapshot < Ohm::Model
    include Ohm::Timestamping
    include Ohm::Typecast
    include Ohm::Callbacks
    include Ohm::ExtraValidations
    
    attr_accessor :raw_data

    reference :resource, "Overwatch::Resource"
    
    after :save, :parse_data
    after :save, :run_checks

    def parse_data
      Overwatch.redis.set "snapshots:#{self.id}:data", Yajl.dump(self.raw_data)
    end
    
    def data
      Hashie::Mash.new(Yajl.load(Overwatch.redis.get "snapshots:#{self.id}:data"))
    end
    
    def run_checks
      Overwatch::Resource[self.resource_id].run_checks
    end
  end # class Snapshot 
end # module Overwatch