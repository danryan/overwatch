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
  
  def schedule_reaper
    if self.created_at.min % 5 != 0
      Resque.enqueue_in(60.minutes, SnapshotReaper, self)
      # Resque.enqueue_in(60.minutes, AttributeReaper, "asset:#{self.asset.id}:#{key}")
    elsif self.created_at.hour != 0 && self.created_at.min != 0
      Resque.enqueue_in(1.day, SnapshotReaper, self)
    else
      Resque.enqueue_in(30.days, SnapshotReaper, self)
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
  
  def from_dotted_hash(source=self.asset.attribute_keys)
    source.map do |main_value|
      main_value.to_s.split(".").reverse.inject(main_value) do |value, key|
        {key.to_sym => value}
      end
    end
  end
  
  private
  
  def parse_data
    raw_data = Yajl.dump(self.raw_data)
    $redis.set "snapshot:#{self.id}:data", raw_data
    self.to_dotted_hash.each_pair do |key, value|
      timestamp = self.created_at.to_i
      $redis.zadd "asset:#{self.asset.id}:#{key}", timestamp, "#{timestamp}:#{value}"
    end    
  end
  
  def update_attribute_keys
    self.to_dotted_hash.keys.each do |key|
      $redis.sadd "asset:#{self.asset.id}:attribute_keys", key
    end
  end
  # 
  def set_timestamps
    self.created_at_int = self.created_at.to_i
    self.save
  end

end

class AttributeError < Exception; end