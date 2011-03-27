class Node
  include Mongoid::Document
  include Mongoid::Timestamps
      
  field :name, :type => String
  field :ip_address, :type => String
  field :uuid
  index :uuid, :unique => true

  references_and_referenced_in_many :metrics #, :index => true
  references_many :data_points
  
  validates_presence_of :name
  validates_presence_of :ip_address
  validates :uuid, :uniqueness => true, :uuid => true
  
  before_validation :generate_uuid
  after_create :associate_metrics
  
  def data_points_for(metric, start_at=(Time.now - 1.hour), end_at=Time.now)
    self.metrics.where(:key => metric).first.
      data_points.where(:node_id => self.id).
      and(:create_at.gt => start_at).
      and(:created_at.lt => end_at)
  end
  
  def metric(metric)
    self.metrics.where(:key => metric)
  end
  
  private
  
  def associate_metrics
    Metric.all.each do |metric|
      self.metrics << metric
    end
  end
  
  def generate_uuid
    return unless new_record?
    self.uuid ||= Vidibus::Uuid.generate
  end
end
