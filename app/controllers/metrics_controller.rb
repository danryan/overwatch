class MetricsController < ApplicationController
  respond_to :html, :json
  
  before_filter :find_node
  
  def index
    @metrics = @node.metrics.all
    respond_with(@metrics)
  end

  def show
    @metric = @node.metrics.where(:name => params[:id]).limit(1).first
    respond_with(@metric)
  end

  def new
    @metric = @node.metrics.new
    respond_with(@metric)
  end

  def create
    @metric = @node.metrics.new(params[:metric])
    flash[:success] = "Metric created" if @metric.save
    respond_with(@metric, :location => node_metric_url(@node, @metric))
  end
  
  def edit
    @metric = @node.metrics.find_by_slug(params[:id])
    respond_with(@metric)
  end
  
  def update
    @metric = @node.metrics.find_by_slug(params[:id])
    if @metric.update_attributes(params[:metric])
      flash[:success] = "Metric updated"
      respond_with(@metric, :location => node_metric_url(@node, @metric))
    end
  end
  
  def destroy
    @metric = @node.metrics.find_by_slug(params[:id])
    flash[:success] = "Metric destroyed" if @metric.destroy
    respond_with(@metric)
  end
  
  def data
    @metrics = @node.metrics.where(:name => params[:id])

    return false if @metrics.count == 0
    @data = []

    index = @metrics.map{|m|m[:data]}.compact.map(&:keys)[0].map(&:to_sym)

    index.each do |i|
      @data << { :name => i, :data => [] }
    end

    @data.each do |datum|
      @metrics.each do |metric|
        datum[:data] << metric[:data][datum[:name].to_s]
      end
    end
    respond_with(@data)
  end
  
  
  private
  
  def find_node
    @node = Node.find_by_slug(params[:node_id])
  end
end
