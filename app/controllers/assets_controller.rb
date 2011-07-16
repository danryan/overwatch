class AssetsController < ApplicationController
  
  respond_to :html, :json
  
  def index
    @assets = Asset.all
    respond_with @assets
  end
  
  def show
    @asset = Asset.get(params[:id])
    @check = Check.new
    @rule = @check.rules.new
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
  
  def attributes
    @asset = Asset.get(params[:id])
    @attributes = @asset.attribute_keys

    options = { 
      :start_at => (params[:start_at].to_i || nil), 
      :end_at => (params[:end_at].to_i || nil),
      :interval => params[:interval].to_s || 'hour'
    }

    attribute = params[:attr]
    if params[:attr]
      if params[:date] == 'true'
        @attribute = @asset.values_with_dates_for(attribute, options)
        respond_with(@attribute)
      elsif params[:function]
        @attribute = @asset.function(params[:function].to_sym, attribute, options)
        respond_with(@attribute)
      else
        @attribute = @asset.values_for(attribute, options)
        respond_with(@attribute)
      end      
    else
      respond_with(@attributes)
    end
    
  end
  
  def sub_attributes
    @asset = Asset.get(params[:id])
    @attributes = @asset.sub_attributes(params[:attribute])
    respond_to do |wants|
      wants.json { render :json => @attributes }
      wants.js # do
       # render :partial => 'shared/sub_attributes', 
       #        :locals => { :attributes => @attributes }
      # end
    end
  end
end
