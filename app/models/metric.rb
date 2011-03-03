class Metric
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  field :name,  :type => String
  field :data,  :type => Hash

  slug :name
  
  embedded_in :node, :inverse_of => :metrics
  
  scope :hourly, where(:created_at.gt => Time.now - 1.hour).
    and(:created_at.lt => Time.now)
  scope :daily, where(:created_at.gt => Time.now - 1.day).
    and(:created_at.lt => Time.now)
  scope :weekly, criteria.where(:created_at.gt => Time.now - 1.week).
    and(:created_at.lt => Time.now)
  scope :monthly, criteria.where(:created_at.gt => Time.now - 1.month).
    and(:created_at.lt => Time.now)
end
