class AssetsController < ApplicationController
  
  respond_to :html, :json
  
  def index
    @assets = Asset.all
    respond_with @assets
  end
  
  def show
    @asset = Asset.get(params[:id])
    respond_with @asset
  end
  
  def new
    @asset = Asset.new
    respond_with @asset
  end
  
  def create
    @asset = Asset.new(params[:asset])
    if @asset.save
      respond_with @asset
    end
  end
  
  def edit
    @asset = Asset.get(params[:id])
    respond_with @asset
  end
  
  def update
    @asset = Asset.get(params[:id])
    if @asset.update(params[:asset])
      respond_with @asset
    end
  end
  
  def destroy
    @asset = Asset.get(params[:id])
    if @asset.destroy
      respond_with @asset 
    end
  end
end
