require 'spec_helper'

describe Metric do
  it { should reference_and_be_referenced_in_many(:nodes).of_type(Node) }
  it { should reference_many(:data_points).with_foreign_key(:metric_id) }
  it { should be_timestamped_document }
  
  it { should save }
  
end

