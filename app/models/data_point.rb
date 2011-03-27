class DataPoint
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :key, :type => String
  field :value
  
  validates_presence_of :key, :value, :node_id, :metric_id
  
  referenced_in :metric
  referenced_in :node
end
