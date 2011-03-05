class Node
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Vidibus::Uuid::Mongoid
  
  field :name, :type => String
  field :ip_address, :type => String
  slug :name, :as => :key, :index => true

  references_and_referenced_in_many :metrics #, :index => true
  references_many :data_points
  
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
  
  
  # def data(metric_name)
  #     @metrics = self.metrics.where(:name => metric_name)
  # 
  #     @data = []
  #     return @data if @metrics.count == 0
  #     
  #     index = @metrics.map{|m|m[:data]}.compact.map(&:keys)[0].map(&:to_sym)
  # 
  #     index.each do |i|
  #       @data << { :name => i, :data => [] }
  #     end
  # 
  #     @data.each do |datum|
  #       @metrics.each do |metric|
  #         datum[:data] << metric[:data][datum[:name].to_s]
  #       end
  #     end
  #     return @data
  #   end
end
