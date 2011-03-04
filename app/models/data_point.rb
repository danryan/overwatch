class DataPoint
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :key, :type => String
  field :value
  
  referenced_in :metric
  referenced_in :node
end
