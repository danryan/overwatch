require 'spec_helper'

describe NodesController do
  describe '#index' do
    let(:nodes) { [Factory(:node)] }
    before { get :index }
    
    it { should respond_with(:success) }
    it { should route(:get, '/nodes').to(:action => :index) }
    it { should render_template(:index) }
    it { should render_with_layout }
    it { should_not set_the_flash }
  end
  
  describe '#show' do
    let(:node) { Factory(:node) }
    before do
      Node.stub(:find).and_return(node)
      get :show, :id => node.id
    end
    
    it { should respond_with(:success) }
    it { should route(:get, "/nodes/#{node.id}").
      to(:action => :show, :id => node.id) }
    it { should render_template(:show) }
    it { should render_with_layout }
    it { should_not set_the_flash }

  end
  
  describe '#new' do
    let(:node_attrs) { Factory.attributes_for(:node) }
    let(:node) { Factory.stub(:node, node_attrs) }
    before do
      get :new
      Node.stub(:new).with(node_attrs).and_return(node)
    end
    
    it { should respond_with(:success) }
    it { should route(:get, '/nodes/new').to(:action => :new) }
    it { should render_template(:new) }
    it { should render_with_layout }
    it { should_not set_the_flash }
  end
  
  describe '#create' do
    let(:node) { mock_model(::Node).as_null_object }
    
    before do
      Node.stub(:new).and_return(node)
    end
    
    it "creates a new node" do
      ::Node.should_receive(:new).
        with("name" => "Web Server", "ip_address" => "10.0.0.1").
        and_return(node)
      post :create, :node => { 'name' => "Web Server", 'ip_address' => "10.0.0.1" }
    end
    
    context "when node creation is successful" do
      before do
        node.stub(:save).and_return(true)
        post :create
      end
      
      it { should set_the_flash }
      it { should redirect_to node_url(node) }
    end
  end
end