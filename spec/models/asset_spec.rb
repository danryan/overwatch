require 'spec_helper'

describe Asset do
  let(:raw_data) { Factory.attributes_for(:snapshot)[:raw_data] }
  
  before do  
  end
  
  describe ".snapshot_range" do
    it do
      # asset.snapshots.count.should be 5
    end
  end
  
  describe ".previous_update" do
  end
  
  describe ".last_update" do
  end
  
  describe 'Resque Jobs' do
    describe ".run_checks" do
    end
  
    describe ".schedule_no_data_check" do
    
    end
  end
  
  describe ".regenerate_api_key" do
    let(:asset) { Factory(:asset) }
    
    it "regenerates the api key" do
      old_key = asset.api_key
      asset.regenerate_api_key
      asset.api_key.should_not == old_key
    end
    
  end
  
  describe "#find_by_name_or_id" do
    let(:asset) { Factory(:asset) }
    
    it "finds an asset by id" do
      Asset.find_by_name_or_id(asset.id).id.should == asset.id
    end
    
    it "finds an asset by name" do
      Asset.find_by_name_or_id(asset.name).name.should == asset.name
    end
  end
  
  describe ".attribute_keys" do
    let(:asset) { Factory(:asset) }
    before do
      5.times { asset.snapshots.create(:raw_data => raw_data) }
    end
    
    it "stores all possible attributes for all snapshots" do
      asset.attribute_keys.should include("cheeses.provolone")
    end
  end
  
  describe ".values_for" do
    let(:asset) { Factory(:asset) }
    before do
      5.times { asset.snapshots.create(:raw_data => raw_data) }
    end
    
    it "gets the values for a given attribute" do
      asset.values_for("cheeses.gouda").should be_an Array
    end
    
    it "only grabs values that contain a number" do
      asset.values_for("cheeses.provolone")[2].should_not be_a String
      asset.values_for("cheeses.provolone")[2].should be_a Fixnum
    end
    
    it "raises an exception if the given attribute does not exist" do
      expect { asset.values_for("cheeses.bacon") }.to raise_error
    end
    
  end
  
  describe ".values_with_dates_for" do
    let(:asset) { Factory(:asset) }
    before do
      5.times { asset.snapshots.create(:raw_data => raw_data) }
    end
    
    it "first value is a DateTime" do
      asset.values_with_dates_for("cheeses.provolone")[3][0].should be_a DateTime
      puts asset.values_for("cheeses.gouda").inspect
    end
  end
  
  describe ".function" do
    
  end
  
  describe ".average" do
    
  end
  
  describe ".min" do
    
  end
  
  describe ".max" do
    
  end
  
  describe ".median" do
    
  end


end