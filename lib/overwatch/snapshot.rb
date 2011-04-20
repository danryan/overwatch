module Overwatch
  class Snapshot
    include Mongoid::Document
    include Mongoid::Timestamps::Created
    
    attr_accessor :raw_data
    # field :data, :type => Hash
    embedded_in :node, :class_name => "Overwatch::Node"
    
    before_save :parse_data
    after_save :run_checks

    def parse_data
      data = to_dotted_hash(self.raw_data)
      Overwatch.redis.mapped_hmset "snapshots:#{self._id}:data", data
    end
      
    def to_dotted_hash(source, target = {}, namespace = nil)
      prefix = "#{namespace}." if namespace
      case source
      when Hash
        source.each do |key, value|
          to_dotted_hash(value, target, "#{prefix}#{key}")
        end
      when Array
        source.each_with_index do |value, index|
          to_dotted_hash(value, target, "#{prefix}#{index}")
        end
      else
        target[namespace] = source
      end
      target
    end # to_dotted_hash
    
    def data
      Overwatch.redis.hgetall "snapshots:#{self._id}:data"
    end
    
    def run_checks
      self.node.run_checks
    end
  end # class Snapshot 
end # module Overwatch