class Metric
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name,  :type => String
  
  references_and_referenced_in_many :nodes #, :index => true
  references_many :data_points
  
end
