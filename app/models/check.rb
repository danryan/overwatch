class Check
  include DataMapper::Resource
  
  property :id, Serial, :index => true
  property :created_at, DateTime
  property :updated_at, DateTime
  
  has n, :assets, :through => :asset_check
  has n, :events, :through => :check_event
  has n, :rules
  
  def run(snapshot)
    rules.each do |rule|
      if rule.run(snapshot)
        next
      else
        fire!(snapshot, rule)
        return false
      end
    end
    return true
  end
  
  def fire!(snapshot, rule)
    events.each do |event|
      event.run(snapshot, self, rule)
    end
  end
end
