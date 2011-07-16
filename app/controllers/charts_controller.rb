class ChartsController < ApplicationController
  
  respond_to :html, :json
  
  before_filter :get_asset
  
  def index
    @charts = @asset.charts.all
    respond_with(@charts)
  end

  def show
    @chart =  @asset.charts.get(params[:id])
    @attributes = @asset.attribute_keys
    
    respond_with(@chart)
  end

  def new
    @chart =  @asset.charts.new
    respond_with(@chart)
  end
  
  def create
    params[:chart][:metrics].reject! {|m| m.blank? }
    @chart =  @asset.charts.new(params[:chart])
    
    respond_to do |wants|
      if @chart.save!
        wants.html { redirect_to asset_chart_url(@asset, @chart) }
        wants.json { render :json => @chart }
      else
        wants.html { render :new }
        wants.json { render :json => @chart.errors }
      end
    end
  end

  def edit
    @chart =  @asset.charts.get(params[:id])
    respond_with(@chart)
  end
  
  def update
    @chart =  @asset.charts.get(params[:id])
    if @chart.update(params[:chart])
      respond_with(@chart)
    end
  end
  
  def destroy
    @chart =  @asset.charts.get(params[:id])
    if @chart.destroy
      respond_with(@chart)
    end
  end

  private
  
  def get_asset
    if params[:asset_id]
      @asset = Asset.get(params[:asset_id])
    elsif params[:key]
      @asset = Asset.first(:api_key => params[:key])
    else
      @asset = nil
    end
  end
  
end
