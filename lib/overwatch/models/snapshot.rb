module Overwatch
  class Snapshot
    include Mongoid::Document
    include Mongoid::Timestamps::Created
    
    attr_accessor :raw_data
    field :data, :type => Hash
    referenced_in :node, :class_name => "Overwatch::Node"
    
    before_save :serialize_data
    
    def serialize_data
      self[:data] = YAML.dump(to_dotted_hash(self.raw_data))
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
      YAML.load(self[:data])
    end
  end # class Snapshot 
end # module Overwatch