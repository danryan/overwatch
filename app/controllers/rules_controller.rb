class RulesController < ApplicationController
  respond_to :html, :json
  
  def index
    @rules = @check.rules.all
    respond_with @rules
  end
  
  def show
    @rule = @check.rules.get(params[:id])
    respond_with @rule
  end
  
  def new
    @rule = @check.rules.new
    respond_with @rule
  end
  
  def create
    @rule = @check.rules.new(params[:rule])
    if @rule.save
      respond_with @rule
    end
  end
  
  def edit
    @rule = @check.rules.get(params[:id])
    respond_with @rule
  end
  
  def update
    @rule = @check.rules.get(params[:id])
    if @rule.update(params[:rule])
      respond_with @rule
    end
  end
  
  def destroy
    @rule = @check.rules.get(params[:id])
    if @rule.destroy
      respond_with @rule 
    end
  end
  
  private
  
  def get_check
    @check = Check.get(params[:check_id])
  end
end
