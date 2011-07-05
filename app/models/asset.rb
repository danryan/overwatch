class Asset
  include DataMapper::Resource

  property :id, Serial

  property :created_at, DateTime, :index => true
  property :updated_at, DateTime
  property :name, String, :index => true, :unique => true, :required => true
  property :api_key, String, :index => true, :unique => true
  property :type, Discriminator
  
  has n, :snapshots
  has n, :checks, :through => :asset_check
  has n, :events, :through => :checks
  
  before :create, :generate_api_key
  after :create, :schedule_no_data_check
  
  accepts_nested_attributes_for :checks
  
  def snapshot_range(start_at=nil, end_at=nil)
    s = start_at || DateTime.now - 1.hour
    e = end_at || DateTime.now
    self.snapshots.all(:created_at.gte => s, :created_at.lte => e)
  end
  
  def previous_update
    snapshots[-2]
  end
  
  def last_update
    snapshots[-1]
  end
  
  def run_checks
    Resque.enqueue(CheckRun, self.id.to_s)
  end
  
  def schedule_no_data_check
    Resque.enqueue_in(5.minutes, NoDataCheck, self)
  end
  
  def regenerate_api_key
    generate_api_key
    self.save
  end
  
  def self.find_by_name_or_id(name_or_id)
    self.first(:id => name_or_id) || self.first(:name => name_or_id) rescue nil
  end
  
  def attribute_keys
    Overwatch.redis.smembers "asset:#{self.id}:attribute_keys"
  end
  
  def average(attr, options={})
    function(:average, attr, options)
  end
  
  def min(attr, options={})
    function(:min, attr, options)
  end
  
  def max(attr, options={})
    function(:man, attr, options)
  end
  
  def median(attr, options={})
    function(:median, attr, options)
  end

  def function(func, attr, options={})
    case func
    when :max
      values_for(attr, options)[:data].max
    when :min
      values_for(attr, options)[:data].min
    when :average
      values = values_for(attr, options)[:data]
      values.inject { |sum, e| sum + e }.to_f / values.size  
    when :median
      values = values_for(attr, options)[:data].sort
      mid = values.size / 2
      values[mid]
    end
  end

  def values_for(attr, options={})
    raise ArgumentError, "attribute does not exist" unless attribute_keys.include?(attr)
    start_at = options[:start_at] || Time.now - 1.hour
    end_at = options[:end_at] || Time.now
    interval = options[:interval] || nil
    case interval
    when 'minute'
      values = snapshots.all(
        :order => [ :created_at.desc ],
        :created_at.gte => start_at, 
        :created_at.lte => end_at
      ).inject([]) do |result, snap|
        result << snap.to_dotted_hash[attr]
      end
    when 'quarter'
      values = snapshots.all(
        :order => [ :created_at.desc ],
        :created_at.gte => start_at, 
        :created_at.lte => end_at,
        :created_at_min => [0, 15, 30, 45]
      ).inject([]) do |result, snap|
        result << snap.to_dotted_hash[attr]
      end
    when 'hour'
      values = snapshots.all(
        :order => [ :created_at.desc ],
        :created_at.gte => start_at, 
        :created_at.lte => end_at,
        :created_at_min => 0
      ).inject([]) do |result, snap|
        result << snap.to_dotted_hash[attr]
      end
    when 'day'
      values = snapshots.all(
        :order => [ :created_at.desc ],
        :created_at.gte => start_at, 
        :created_at.lte => end_at,
        :created_at_hour => 0,
        :created_at_min => 0
      ).inject([]) do |result, snap|
        result << snap.to_dotted_hash[attr]
      end
    else
      values = snapshots.all(
        :order => [ :created_at.desc ],
        :created_at.gte => start_at, 
        :created_at.lte => end_at
      ).inject([]) do |result, snap|
        result << snap.to_dotted_hash[attr]
      end    
    end
    
    # values.select! { |value| is_a_number?(value) }
    values.compact!
    { :name => attr, :data => values }#, :start_at => start_at, :end_at => end_at }
    
  end
  
  def values_with_dates_for(attr, options={})
    raise ArgumentError, "attribute does not exist" unless attribute_keys.include?(attr)
    start_at = options[:start_at] || Time.now - 1.hour
    end_at = options[:end_at] || Time.now
    interval = options[:interval] || nil
    values = case interval
    when 'minute'
      snapshots.all(
        :order => [ :created_at.desc ],
        :created_at.gte => start_at, 
        :created_at.lte => end_at
      )
    when 'quarter'
      snapshots.all(
        :order => [ :created_at.desc ],
        :created_at.gte => start_at, 
        :created_at.lte => end_at,
        :created_at_min => [0, 15, 30, 45]
      )
    when 'hour'
      snapshots.all(
        :order => [ :created_at.desc ],
        :created_at.gte => start_at, 
        :created_at.lte => end_at,
        :created_at_min => 0
      )
    when 'day'
      snapshots.all(
        :order => [ :created_at.desc ],
        :created_at.gte => start_at, 
        :created_at.lte => end_at,
        :created_at_hour => 0,
        :created_at_min => 0
      )
    else
      snapshots.all(
        :order => [ :created_at.desc ],
        :created_at.gte => start_at, 
        :created_at.lte => end_at
      )  
    end.inject([]) do |result, snap|
      result << [ (snap.created_at.to_i * 1000), snap.to_dotted_hash[attr] ]
    end
    
    # values.map! { |value| [ value[0], value[1] }
    values.compact!
    { :name => attr, :data => values } #, :start_at => start_at, :end_at => end_at }
  end
  
  private
  
  def is_a_number?(value)
    [Fixnum, Integer, Float].include?(value.class)
  end
  
  def generate_api_key
    api_key = Digest::SHA1.hexdigest(Time.now.to_s + rand(12341234).to_s)[1..30]
    self.api_key = api_key
  end
end
