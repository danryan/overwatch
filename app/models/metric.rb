class Metric
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, :type => String
  field :data, :type => Hash
  
  embedded_in :node, :inverse_of => :metrics
end
