class SnapshotsController < ApplicationController
  respond_to :html, :json

  before_filter :get_asset
  
  def index
    @snapshots = @asset.snapshots.all
    respond_with @snapshots
  end
  
  def show
    @snapshot = @asset.snapshots.get(params[:id])
    respond_with @snapshot
  end
  
  def new
    @snapshot = @asset.snapshots.new
    respond_with @snapshot
  end
  
  def create
    @snapshot = @asset.snapshots.new(params[:snapshot])
    if @asset.save
      respond_with @snapshot
    end
  end
  
  def edit
    @snapshot = @asset.snapshots.get(params[:id])
    respond_with @snapshot
  end
  
  def update
    @snapshot = @asset.snapshots.get(params[:id])
    if @asset.update(params[:snapshot])
      respond_with @snapshot
    end
  end
  
  def destroy
    @snapshot = @asset.snapshots.get(params[:id])
    if @snapshot.destroy
      respond_with @snapshot 
    end
  end
  
  private
  
  def get_asset
    @asset = Asset.get(params[:asset_id])
  end
end
