class MetricsController < ApplicationController
  respond_to :html, :json
  
  before_filter :find_node
  
  def index
    @metrics = @node.metrics.all
    respond_with(@metrics)
  end

  def show
    @metric = @node.metrics.find(params[:id])
    respond_with(@metric)
  end

  def new
    @metric = @node.metrics.new
    respond_with(@metric)
  end

  def create
    @metric = @node.metrics.new(params[:metric])
    flash[:success] = "Metric created" if @metric.save
    respond_with(@metric, :location => metric_url(@metric))
  end
  
  def edit
    @metric = @node.metrics.find(params[:id])
    respond_with(@metric)
  end
  
  def update
    @metric = @node.metrics.find(params[:id])
    if @metric.update_attributes(params[:metric])
      flash[:success] = "Metric updated"
      respond_with(@metric, :location => metric_url(@metric))
    end
  end
  
  def destroy
    @metric = @node.metrics.find(params[:id])
    flash[:success] = "Metric destroyed" if @metric.destroy
    respond_with(@metric)
  end
  
  private
  
  def find_node
    @node = Node.find(params[:node_id])
  end
end
