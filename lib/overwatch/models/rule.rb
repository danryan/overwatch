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
    def self.if(attr)
      rule = new(:attr => attr)
      rule.save
      rule
    end
    
    def less_than(arg)
      self[:conditions] << [:less_than, arg]
      self.save
      self
      # self[:attribute] < arg
    end
    
    def greater_than(arg)
      self[:conditions] << [:greater_than, arg]
      self.save
      self
    end
    
    def is(arg)
      self[:conditions] << [:is, arg]
      self.save
      self
    end
    
    def is_not(arg)
      self[:conditions] << [:is_not, arg]
      self.save
      self
    end
  
  end # class Rule
end # module Overwatch

# Rule.new(
#   :attribute => "[:foo][:bar]",
#   :matcher => :is,
#   :argument => "baz"
# )

