class Metric
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, :type => String
  field :data, :type => Hash
  
  referenced_in :node, :inverse_of => :metrics
  
  class << self
    def last_hour
      criteria.where(:created_at.gt => Time.now - 1.hour).
        and(:created_at.lt => Time.now)
    end
  end
end
