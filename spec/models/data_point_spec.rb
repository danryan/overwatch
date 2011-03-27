require 'spec_helper'

describe DataPoint do
  it { should be_referenced_in(:node).of_type(Node) }
  it { should be_referenced_in(:metric).of_type(Metric) }
  
  it { should validate_presence_of :key }
  it { should validate_presence_of :value }
  it { should validate_presence_of :node_id }
  it { should validate_presence_of :metric_id }
  
  it { should be_timestamped_document }
  
  it { should save }
end
