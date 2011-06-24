class Event
  include DataMapper::Resource
  
  property :id, Serial, :index => true
  property :created_at, DateTime
  property :updated_at, DateTime
  property :type, Discriminator
  
  has n, :checks, :through => :check_event
  
  def run(snapshot, check, resource)
  end

end
