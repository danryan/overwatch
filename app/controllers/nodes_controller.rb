class NodesController < ApplicationController
  respond_to :html, :json
  
  def index
    @nodes = Node.all.only(:slug, :ip_address)
    respond_with(@nodes)
  end

  def show
    @node = Node.find_by_slug(params[:id])
    respond_with(@node)
  end

  def new
    @node = Node.new
    respond_with(@node)
  end

  def create
    @node = Node.new(params[:node])
    flash[:success] = "Node created" if @node.save
    respond_with(@node)
  end
  
  def edit
    @node = Node.find_by_slug(params[:id])
    respond_with(@node)
  end
  
  def update
    @node = Node.find_by_slug(params[:id])
    if @node.update_attributes(params[:node])
      flash[:success] = "Node updated"
      respond_with(@node, :location => node_url(@node))
    end
  end
  
  def destroy
    @node = Node.find_by_slug(params[:id])
    flash[:success] = "Node destroyed" if @node.destroy
    respond_with(@node)
  end
end
