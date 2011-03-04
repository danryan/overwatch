class DataPointsController < ApplicationController
  respond_to :html, :json
  
  before_filter :find_node
  
  def index
    @data_points = @node.data_points.all
    respond_with(@data_points)
  end

  def show
    @data_point = @node.data_points.where(:name => params[:id]).limit(1).first
    respond_with(@data_point)
  end

  def new
    @data_point = @node.data_points.new
    respond_with(@data_point)
  end

  def create
    @data_point = @node.data_points.new(params[:data_point])
    flash[:success] = "DataPoint created" if @data_point.save
    respond_with(@data_point, :location => node_data_point_url(@node, @data_point))
  end
  
  def edit
    @data_point = @node.data_points.find_by_slug(params[:id])
    respond_with(@data_point)
  end
  
  def update
    @data_point = @node.data_points.find_by_slug(params[:id])
    if @data_point.update_attributes(params[:data_point])
      flash[:success] = "DataPoint updated"
      respond_with(@data_point, :location => node_data_point_url(@node, @data_point))
    end
  end
  
  def destroy
    @data_point = @node.data_points.find_by_slug(params[:id])
    flash[:success] = "DataPoint destroyed" if @data_point.destroy
    respond_with(@data_point)
  end
  
  def data
    @data_points = @node.data_points.where(:name => params[:id])

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
    @node = Node.find_by_slug(params[:node_id])
  end
end
