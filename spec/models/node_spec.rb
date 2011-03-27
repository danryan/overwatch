require 'spec_helper'

describe Node do
  it { should reference_and_be_referenced_in_many(:metrics).of_type(Metric) }
  it { should reference_many(:data_points).with_foreign_key(:node_id) }
  
  it { should validate_presence_of :name }
  it { should validate_presence_of :ip_address }
  
  it { should be_timestamped_document }
  
  it { should save }
  
end