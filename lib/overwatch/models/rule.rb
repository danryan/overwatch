module Overwatch
  class Rule
    include Mongoid::Document
    field :attribute, :type => String
    field :condition, :type => Symbol
    field :argument
    
    referenced_in :check, :class_name => "Overwatch::Check"
    
    def run(snapshot)
      case self[:condition]
      when :is
        return snapshot.data[self[:attribute]] == self[:argument]
      when :is_not
        return snapshot.data[self[:attribute]] != self[:argument]
      when :greater_than
        return snapshot.data[self[:attribute]] > self[:argument]
      when :less_than
        return snapshot.data[self[:attribute]] < self[:argument]
      end
    end
    
    # .if is a essentially a shortcut macro to instantiate a new Rule, save it and return it, allowing one to chain conditions.
    def self.if(attr)
      rule = new(:attribute => attr)
      rule.save
      rule
    end
    
    def less_than(arg)
      self[:condition] = :less_than
      self[:argument] = arg
      self.save
      valid_types = [Fixnum, Float, Bignum, Numeric, Rational]
      unless valid_types.include?(arg.class)
        raise ArgumentError, "argument must be a type of #{valid_types.join(',')}"
      end
      self
      # self[:attribute] < arg
    end
    
    def greater_than(arg)
      self[:condition] = :greater_than
      self[:argument] = arg 
      self.save
      valid_types = [Fixnum, Float, Bignum, Numeric, Rational]
      unless valid_types.include?(arg.class)
        raise ArgumentError, "argument must be a type of #{valid_types.join(', ')}"
      end
      self
      # self[:attribute] > arg
    end
    
    def is(arg)
      self[:condition] = :is
      self[:argument] = arg
      self.save
      self
      # self[:attribute] == arg
    end
    
    def is_not(arg)
      self[:condition] = :is_not
      self[:argument] = arg
      self.save
      self
      # self[:attribute] != arg
    end
  
  end # class Rule
end # module Overwatch

# Rule.new(
#   :attribute => "[:foo][:bar]",
#   :matcher => :is,
#   :argument => "baz"
# )

