module Overwatch
  class Node
    include Mongoid::Document
    include Mongoid::Timestamps
    
    field :name, :type => String
    index :name
    
    references_many :snapshots, :class_name => "Overwatch::Snapshot"
    references_and_referenced_in_many :checks, :class_name => "Overwatch::Check"
    
    validates_presence_of :name
    validates_uniqueness_of :name
    
    def previous_update
      snapshots.order_by(:created_at)[-2]
    end # last_update
    
  end # class Node
end # module Overwatch