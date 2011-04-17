module Overwatch
  class Rule
    include Mongoid::Document
    field :attr, :type => String
    field :conditions, :type => Array, :default => []
    
    referenced_in :check, :class_name => "Overwatch::Check"
    
    def run(snapshot)
      conditions.each do |condition|
        case condition[0]
        when :is
          return snapshot.data[self.attr] == condition[1]
        when :is_not
          return snapshot.data[self.attr] != condition[1]
        when :greater_than
          return snapshot.data[self.attr] > condition[1].to_s
        when :less_than
          return snapshot.data[self.attr] < condition[1].to_s
        end
      end
    end
    
    # .if is a essentially a shortcut macro to instantiate a new Rule, save it 
    # and return it, allowing one to chain conditions.
    
    def to_s
      conds = conditions.map {|c| "#{humanized_keys.values_at(c[0]).first} #{c[1]}" }
      "#{self.attr} #{conds.join(' and ')}"
    end
    
    def self.if(attr)
      rule = new(:attr => attr)
      rule.save
      rule
    end
    
    def less_than(arg)
      self[:conditions] << [:less_than, arg]
      self.save
      self
    end
    
    alias_method :is_less_than, :less_than
    alias_method :is_lt, :less_than
    alias_method :lt, :less_than
    # alias_method :<, :less_than
    
    def greater_than(arg)
      self[:conditions] << [:greater_than, arg]
      self.save
      self
    end
    
    alias_method :is_greater_than, :greater_than
    alias_method :is_gt, :greater_than
    alias_method :gt, :greater_than
    # alias_method :>, :greater_than
    
    def is(arg)
      self[:conditions] << [:is, arg]
      self.save
      self
    end
    
    alias_method :equals, :is
    alias_method :equal_to, :is
    alias_method :eq, :is
    # alias_method :==, :is
    
    def is_not(arg)
      self[:conditions] << [:is_not, arg]
      self.save
      self
    end
    
    alias_method :isnt, :is_not
    alias_method :ne, :is_not
    alias_method :not_equal_to, :is_not
    # alias_method :!=, :is
  
    private
    
    def humanized_keys
      {
        :is => "is",
        :is_not => "is not",
        :greater_than => "is greater than",
        :less_than => "is less than"
      }
    end
  end # class Rule
end # module Overwatch