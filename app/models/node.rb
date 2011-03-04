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
