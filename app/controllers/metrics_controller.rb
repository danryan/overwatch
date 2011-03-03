class MetricsController < ApplicationController
  respond_to :html, :json
  
  def index
    @metrics = Metric.all
    respond_with(@metric)
  end

  def show
    @metric = Metric.find(params[:id])
    respond_with(@metric)
  end

  def new
    @metric = Metric.new
    respond_with(@metric)
  end

  def create
    @metric = Metric.new(params[:metric])
    flash[:success] = "Metric created" if @metric.save
    respond_with(@metric, :location => metric_url(@metric))
  end
  
  def edit
    @metric = Metric.find(params[:id])
    respond_with(@metric)
  end
  
  def update
    @metric = Metric.find(params[:id])
    if @metric.update_attributes(params[:metric])
      flash[:success] = "Metric updated"
      respond_with(@metric, :location => metric_url(@metric))
    end
  end
  
  def destroy
    @metric = Metric.find(params[:id])
    flash[:success] = "Metric destroyed" if @metric.destroy
    respond_with(@metric)
  end
end
