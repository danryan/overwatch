class Node
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  field :name, :type => String
  field :ip_address, :type => String
  
  # index "metrics.name", :unique => true
  
  slug :name
  # validates_presence_of :name, :ip_address
  
  embeds_many :metrics, :dependent => :destroy
  
  def data(metric_name)
    @metrics = self.metrics.where(:name => metric_name)
    # @metrics = @node.metrics.where(:name => params[:id])

    @data = []
    return @data if @metrics.count == 0
    
    index = @metrics.map{|m|m[:data]}.compact.map(&:keys)[0].map(&:to_sym)

    index.each do |i|
      @data << { :name => i, :data => [] }
    end

    @data.each do |datum|
      @metrics.each do |metric|
        datum[:data] << metric[:data][datum[:name].to_s]
      end
    end
    return @data
  end
end
