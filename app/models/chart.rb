class Chart
  include DataMapper::Resource

  property :id, Serial
  property :title, String, :unique => true
  property :created_at, DateTime
  property :updated_at, DateTime
  property :metrics, Json
  
  belongs_to :asset
  # has n, :metrics
    
end
