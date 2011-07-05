class ChecksController < ApplicationController
  respond_to :html, :json, :js
  
  before_filter :get_asset
  
  def index
    if @asset
      @checks = @asset.checks.all
    else
      @checks = Check.all
    end
    respond_with @checks
  end
  
  def show
    if @asset
      @check = @asset.checks.get(params[:id])
    else
      @check = Check.get(params[:id])
    end
    respond_with @check
  end
  
  def new
    @check = Check.new
    @check.rules.new
    respond_with @check
  end
  
  def create
    @check = Check.new(params[:check])
    @check.assets << @asset if @asset
    if @check.save
      respond_with @check do |wants|
        wants.html do
          if @asset
            redirect_to asset_check_path(@asset, @check)
          else
            redirect_to check_path(@check)
          end
        end
        wants.json { @check.to_json }
        wants.js
      end
    end
  end
  
  def edit
    @check = Check.get(params[:id])
    respond_with @check
  end
  
  def update
    @check = Check.get(params[:id])
    if @check.update(params[:check])
      respond_with @check
    end
  end
  
  def destroy
    @check = Check.get(params[:id])
    if @check.destroy
      respond_with @check 
    end
  end
  
  private
  
  def get_asset
    @asset = Asset.get(params[:asset_id])
  end
  
end
