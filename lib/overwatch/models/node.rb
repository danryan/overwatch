$:.unshift File.expand_path(File.join(File.dirname(__FILE__), "../.."))
require 'overwatch/models/snapshot'

module Overwatch
  class Node < Ohm::Model
    include Ohm::Timestamping
    include Ohm::Typecast
    include Ohm::Callbacks
    include Ohm::ExtraValidations
    include Ohm::Slug
    
    attribute :name, String
    list :snapshots, Snapshot
    index :name
    
    def to_hash
      super.merge(:name => name)
    end # to_hash
    
    def to_s
      name.to_s
    end # to_s

    def validate
      # super
      assert_present :name
      assert_unique :name
    end # validate
    
    def last_update
      return self.snapshots[-2]
    end # last_update
    
  end # class Node
end # module Overwatch