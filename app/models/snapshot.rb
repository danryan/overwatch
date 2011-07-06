class Snapshot
  include DataMapper::Resource

  include DataMapper::Resource
  
  property :id, Serial, :index => true
  property :created_at, DateTime
  property :created_at_hour, Integer
  property :created_at_min, Integer
  property :created_at_int, Integer
  
  attr_accessor :data
  attr_accessor :raw_data
  
  belongs_to :asset
  
  after :create, :parse_data
  after :create, :run_checks
  after :create, :update_attribute_keys
  after :create, :set_timestamps
  after :create, :schedule_reaper
  
  def parse_data
    raw_data = Yajl.dump(self.raw_data)
    $redis.set "snapshot:#{self.id}:data", raw_data
  end
  
  def data
    begin
      Hashie::Mash.new(
        Yajl.load($redis.get("snapshot:#{self.id}:data"))
      )
    rescue
    end
  end
  
  def run_checks
    self.asset.run_checks
  end
  
  def update_attribute_keys
    self.to_dotted_hash.keys.each do |key|
      $redis.sadd "asset:#{self.asset.id}:attribute_keys", key
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
    if self.created_at.min % 5 != 0
      Resque.enqueue_in(60.minutes, SnapshotReaper, self)
    elsif self.created_at.hour != 0 && self.created_at.min != 0
      Resque.enqueue_in(1.day, SnapshotReaper, self)
    else
      Resque.enqueue_in(30.days, SnapshotReaper, self)
    end
  end
  
  def set_timestamps
    time = DateTime.now.round(1.minute)
    self.created_at = time
    self.created_at_int = time.to_i
    self.created_at_hour = time.hour
    self.created_at_min = time.min
    self.save
  end
  
end

class AttributeError < Exception; end