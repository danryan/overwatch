class DataPointsController < ApplicationController
  respond_to :html, :json
  
  before_filter :find_node
  before_filter :find_metric #, :except => [ :create ]
  
  def index
    @data_points = @metric.data_points.where(:node_id => @node.id)

    @data = []
    
    if @data_points.empty?
      respond_with(@data)
    else
      index = @data_points.map(&:key).uniq

      index.each do |i|
        @data << { :name => i, :data => [] }
      end

      @data.each do |datum|
        @data_points.each do |data_point|
          datum[:data] << data_point[:value]
        end
      end
      respond_with(@data)
    end
  end

  def show
    @data_point = @metric.data_points.find(params[:id])
    respond_with(@data_point)
  end

  def new
    @data_point = @metric.data_points.new
    @data_point[:node_id] = @node.id
    respond_with(@data_point)
  end

  def create
    # @metric = Metric.find_or_create_by(:name => params[:metric])
    @data_point = @metric.data_points.new
    @data_point[:node_id] = @node.id
    @data_point[:key] = !params[:key].nil? ? params[:key] : 0
    @data_point[:value] = !params[:value].nil? ? params[:value] : 0
    flash[:success] = "DataPoint created" if @data_point.save
    respond_with(@data_point, :location => node_metric_datum_url(@node, @metric, @data_point))
  end
  
  def edit
    @data_point = @metric.data_points.find(params[:id])
    respond_with(@data_point)
  end
  
  def update
    @data_point = @metric.data_points.find(params[:id])
    if @data_point.update_attributes(params[:data_point])
      flash[:success] = "DataPoint updated"
      respond_with(@data_point, :location => node_data_point_url(@node, @data_point))
    end
  end
  
  def destroy
    @data_point = @metric.data_points.find_by_slug(params[:id])
    flash[:success] = "DataPoint destroyed" if @data_point.destroy
    respond_with(@data_point)
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
  
  
  private
  
  def find_node
    @node = Node.find_by_key(params[:node_id])
  end
  def find_metric
    @metric = Metric.find_by_key(params[:metric_id])
  end
end
