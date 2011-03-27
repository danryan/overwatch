require 'spec_helper'

describe DataPointsController do
  describe '#index' do
    let(:node) { Factory(:node) }
    let(:metric) { Factory(:metric) }
    let(:data_point) { Factory(:data_point, :node => node, :metric => metric) }
    
    it "should "
  end
end
