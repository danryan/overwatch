class Rule
  include DataMapper::Resource

  include DataMapper::Resource
      
  property :id, Serial, :index => true
  property :created_at, DateTime
  property :updated_at, DateTime
  property :attr, String
  property :condition, String
  property :value, String
  
  belongs_to :check
  
  def run(snapshot)
    case self.condition
    when 'is'
      return snapshot.data.instance_eval(self.attr) == self.value
    when 'is_not'                                     
      return snapshot.data.instance_eval(self.attr) != self.value
    when 'greater_than'                               
      return snapshot.data.instance_eval(self.attr) > self.value
    when 'less_than'                                    
      return snapshot.data.instance_eval(self.attr) < self.value
    end
  end
  
  # .if is a essentially a shortcut macro to instantiate a new Rule, save it 
  # and return it, allowing one to chain cond.
  
  def to_s
    cond = cond.map {|c| "#{humanized_keys.values_at(c[0]).first} #{c[1]}" }
    "#{self.attr} #{cond.join(' and ')}"
  end
  
  def self.if(attr)
    rule = new(:attr => attr)
    rule.save
    rule
  end
  
  def less_than(value)
    self.cond = 'less_than'
    self.value = ''
    self.save
    self
  end
  
  alias_method :is_less_than, :less_than
  alias_method :is_lt, :less_than
  alias_method :lt, :less_than
  
  def greater_than(value)
    self.cond = 'greater_than'
    self.value = value
    self.save
    self
  end
  
  alias_method :is_greater_than, :greater_than
  alias_method :is_gt, :greater_than
  alias_method :gt, :greater_than
  
  def is(value)
    self.cond = 'is'
    self.value = value
    self.save
    self
  end
  
  alias_method :equals, :is
  alias_method :equal_to, :is
  alias_method :eq, :is
  
  def is_not(value)
    self.cond = 'is_not'
    self.value = value
    self.save
    self
  end
  
  alias_method :isnt, :is_not
  alias_method :ne, :is_not
  alias_method :not_equal_to, :is_not

  private
  
  def humanized_keys
    {
      'is' => "is",
      'is_not' => "is not",
      'greater_than' => "is greater than",
      'less_than' => "is less than"
    }
  end

end
