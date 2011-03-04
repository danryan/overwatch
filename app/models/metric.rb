class Metric
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  field :name,  :type => String
  slug :name, :as => :key, :index => true
  
  references_and_referenced_in_many :nodes #, :index => true
  references_many :data_points
  
  # scope :hourly, where(:created_at.gt => Time.now - 1.hour).
  #   and(:created_at.lt => Time.now)
  # scope :daily, where(:created_at.gt => Time.now - 1.day).
  #   and(:created_at.lt => Time.now)
  # scope :weekly, criteria.where(:created_at.gt => Time.now - 1.week).
  #   and(:created_at.lt => Time.now)
  # scope :monthly, criteria.where(:created_at.gt => Time.now - 1.month).
  #   and(:created_at.lt => Time.now)
end
