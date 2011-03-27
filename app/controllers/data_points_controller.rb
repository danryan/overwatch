class DataPointsController < InheritedResources::Base
  respond_to :html, :json
  belongs_to :node do
    belongs_to :metric
  end
  # defaults :as => :data, :path => :data

  def index
    index! do |format|      
      # @data_points = parent.data_points.where(:node_id => @node.id)
      @data = []
    
      if collection.empty?
        format.html do
          respond_with(@data)
        end
      else
        index = collection.map(&:key).uniq

        index.each do |i|
          @data << { :name => i, :data => [] }
        end

        @data.each do |datum|
          collection.each do |data_point|
            datum[:data] << data_point[:value]
          end
        end
        format.html do
          respond_with(@data)
        end
      end
    end
  end
  
  def create
    @node = Node.find(params[:node_id])
    @metric = Metric.find(params[:metric_id])
    @data_point = DataPoint.new(params[:data_point])
    @data_point.node = @node
    @data_point.metric = @metric
    create!
  end
    
  def update
    @node = Node.find(params[:node_id])
    @metric = Metric.find(params[:metric_id])
    @data_point = DataPoint.find(params[:id])
    @data_point.node = @node
    @data_point.metric = @metric
    update!
  end

  protected
    def collection
      @metric = Metric.find(params[:metric_id])
      @data_points ||= @metric.data_points.where(:node_id => params[:node_id])
    end
    
  def data
    @data_points = @metric.data_points.where(:name => params[:id])

    return false if @data_points.count == 0
    @data = []
    
    index = @data_points.map{|m|m[:data]}.compact.map(&:keys)[0].map(&:to_sym)

    index.each do |i|
      @data << { :name => i, :data => [] }
    end

    @data.each do |datum|
      @data_points.each do |data_point|
        datum[:data] << data_point[:data][datum[:name].to_s]
      end
    end
    respond_with(@data)
  end
end
