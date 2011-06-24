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

  #   
  #   def average(attr, options={})
  #     function(:average, attr, options)
  #   end
  #   
  #   def min(attr, options={})
  #     function(:min, attr, options)
  #   end
  #   
  #   def max(attr, options={})
  #     function(:man, attr, options)
  #   end
  #   
  #   def median(attr, options={})
  #     function(:median, attr, options)
  #   end
  # 
  #   def function(func, attr, options={})
  #     case func
  #     when :max
  #       values_for(attr, options).max
  #     when :min
  #       values_for(attr, options).min
  #     when :average
  #       values = values_for(attr, options)
  #       values.inject { |sum, e| sum + e }.to_f / values.size  
  #     when :median
  #       values = values_for(attr, options).sort
  #       mid = values.size / 2
  #       values[mid]
  #     end
  #   end
  # 
  #   def values_for(attr, options={})
  #     raise ArgumentError, "attribute does not exist" unless attribute_keys.include?(attr)
  #     start_at = options[:start_at] || Time.now - 1.hour
  #     end_at = options[:end_at] || Time.now 
  #     values = snapshots.all(
  #       :created_at.gte => start_at, 
  #       :created_at.lte => end_at
  #     ).inject([]) do |result, snap|
  #       result << snap.to_dotted_hash[attr]
  #     end
  #     
  #     values.select! { |value| is_a_number?(value) }
  #     values.compact!
  #     values
  #   end
  #   
  #   def values_with_date_for(attr, options={})
  #     raise ArgumentError, "attribute does not exist" unless attribute_keys.include?(attr)
  #     start_at = options[:start_at] || Time.now - 1.hour
  #     end_at = options[:end_at] || Time.now 
  #     values = snapshots.all(
  #       :created_at.gte => start_at, 
  #       :created_at.lte => end_at
  #     ).inject([]) do |result, snap|
  #       result << [ snap.created_at, snap.to_dotted_hash[attr] ]
  #     end
  # 
  #     values.select! { |value| is_a_number?(value[1]) }
  #     values.compact!
  #     values
  #   end
  #   
  #   private
  #   
  #   def is_a_number?(value)
  #     [Fixnum, Integer, Float].include?(value.class)
  #   end
  #   
  #   def generate_api_key
  #     api_key = Digest::SHA1.hexdigest(Time.now.to_s + rand(12341234).to_s)[1..30]
  #     self.api_key = api_key
  #   end
  # end
  