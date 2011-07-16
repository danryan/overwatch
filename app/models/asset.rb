class Asset
  include DataMapper::Resource

  property :id, Serial

  property :created_at, DateTime, :index => true
  property :updated_at, DateTime
  property :name, String, :index => true, :unique => true, :required => true
  property :api_key, String, :index => true, :unique => true
  property :type, Discriminator
  
  has n, :snapshots
  has n, :charts
  has n, :checks, :through => :asset_check
  has n, :events, :through => :checks
  
  before :create, :generate_api_key
  after :create, :schedule_no_data_check
  
  validates_uniqueness_of :name
  accepts_nested_attributes_for :checks
  
  def intervals
    [
      [60, 1440],   # every minute for 24 hours
      [3600, 1440], # every hour for one month
      [86400, 1460] # every day for four years
    ]
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
    function(:max, attr, options)
  end
  
  def median(attr, options={})
    function(:median, attr, options)
  end

  def first(attr, options={})
    function(:first, attr, options)
  end

  def last(attr, options={})
    function(:last, attr, options)
  end
    
  def function(func, attr, options={})
    case func
    when :max
      values_for(attr, options)[:data].max
    when :min
      values_for(attr, options)[:data].min
    when :average
      values = values_for(attr, options)[:data]
      if is_a_number?(values.first)
        values.map!(&:to_f)
        values.inject(:+) / values.size
      else
        values.first
      end
    when :median
      values = values_for(attr, options)[:data].sort
      mid = values.size / 2
      values[mid]
    when :first
      value = $redis.zrangebyscore("asset:#{self.id}:#{attr}", options[:start_at], options[:end_at])[0]
      value.split(":")[1] rescue nil
    when :last 
      value = $redis.zrevrangebyscore("asset:#{self.id}:#{attr}", options[:end_at], options[:start_at])[0]
      value.split(":")[1] rescue nil
    end
  end

  def values_for(attr, options={})
    raise ArgumentError, "attribute does not exist" unless attribute_keys.include?(attr)
    start_at = options[:start_at] || (Time.now - 1.day).to_i.to_s
    end_at = options[:end_at] || Time.now.to_i.to_s
    interval = options[:interval]
    values = $redis.zrangebyscore("asset:#{self.id}:#{attr}", start_at, end_at)
    values.map! do |v|
      val = v.split(":")[1]
      is_a_number?(val) ? val.to_f : val
    end
    values.compact!
    values = case interval
    when 'hour'
      values
    when 'day'
      values.each_slice(60).map { |s| s[0] }
    when 'week'
      values.each_slice(100).map { |s| s[0] }
    when 'month'
      values.each_slice(432).map { |s| s[0] }
    else
      values
    end
    { :name => attr, :data => values }#, :start_at => start_at, :end_at => end_at }
  end
  
  def is_a_number?(str)
    str.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
  end
    
  def values_with_dates_for(attr, options={})
    raise ArgumentError, "attribute does not exist" unless attribute_keys.include?(attr)
    start_at = options[:start_at] || (Time.now - 1.day).to_i.to_s
    end_at = options[:end_at] || Time.now.to_i.to_s
    interval = options[:interval]
    values = $redis.zrangebyscore("asset:#{self.id}:#{attr}", start_at, end_at)
    values.map! do |v|
      val = v.split(":")
      [ val[0].to_i * 1000, is_a_number?(val[1]) ? val[1].to_f : val[1] ]
    end
    values.compact!
    values = case interval
    when 'hour'
      values
    when 'day'
      values.each_slice(60).map { |s| s[0] }
    when 'week'
      values.each_slice(100).map { |s| s[0] }
    when 'month'
      values.each_slice(432).map { |s| s[0] }
    else
      values
    end
    { :name => attr, :data => values } #, :start_at => start_at, :end_at => end_at }
  end
  
  def from_dotted_hash(source=self.attribute_keys)
    source.map do |main_value|
      main_value.to_s.split(".").reverse.inject(main_value) do |value, key|
        {key.to_sym => value}
      end
    end
  end
  
  
  def top_level_attributes
    self.attribute_keys.map do |key|
      key.split(".")[0]
    end.uniq
  end
  
  def sub_attributes(sub_attr)
    self.attribute_keys.select {|k| k =~ /^#{sub_attr}/ }
  end
  
  private

  def generate_api_key
    api_key = Digest::SHA1.hexdigest(Time.now.to_s + rand(12341234).to_s)[1..30]
    self.api_key = api_key
  end
end
