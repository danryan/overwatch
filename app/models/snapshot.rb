class Snapshot
  include DataMapper::Resource

  include DataMapper::Resource
  
  property :id, Serial, :index => true
  property :created_at, DateTime
  property :updated_at, DateTime
      
  attr_accessor :data
  attr_accessor :raw_data
  
  belongs_to :asset
  
  after :create, :parse_data
  after :create, :run_checks
  after :create, :schedule_reaper
  after :create, :update_attribute_keys
  
  def parse_data
    raw_data = Yajl.dump(self.raw_data)
    Overwatch.redis.set "overwatch::snapshot:#{self.id}:data", raw_data
  end
  
  def data
    begin
      Hashie::Mash.new(
        Yajl.load(Overwatch.redis.get("overwatch::snapshot:#{self.id}:data"))
      )
    rescue
    end
  end
  
  def run_checks
    self.asset.run_checks
  end
  
  def update_attribute_keys
    self.to_dotted_hash.keys.each do |key|
      Overwatch.redis.sadd "overwatch::asset:#{self.asset.id}:attribute_keys", key
    end
  end
    
  # Usage: to_dotted_hash({:one => :two}) # => "one.two"
  def to_dotted_hash(source=self.data,target = {}, namespace = nil)
    prefix = "#{namespace}." if namespace
    case source
    when Hash
      source.each do |key, value|
        to_dotted_hash(value, target, "#{prefix}#{key}")
      end
    else
      target[namespace] = source
    end
    target
  end
  
  def schedule_reaper
    Resque.enqueue_in(30.days, SnapshotReaper, self)
  end
  
end

class AttributeError < Exception; end