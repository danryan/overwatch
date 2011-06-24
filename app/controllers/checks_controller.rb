class ChecksController < ApplicationController
  respond_to :html, :json
  
  def index
    @checks = Check.all
    respond_with @checks
  end
  
  def show
    @check = Check.get(params[:id])
    respond_with @check
  end
  
  def new
    @check = Check.new
    respond_with @check
  end
  
  def create
    @check = Check.new(params[:check])
    if @check.save
      respond_with @check
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
end
