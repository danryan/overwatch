module Overwatch
  class Check
    include Mongoid::Document
    
    references_and_referenced_in_many :nodes, :class_name => "Overwatch::Node"
    references_many :rules, :class_name => "Overwatch::Rule"
    
    def run(snapshot)
      rules.each do |rule|
        if rule.run(snapshot)
          next
        else
          return false
        end
      end
      return true
    end
    # def run
    #       rules.each do |rule|
    #         if !rule.is_a(Rule)
    #           raise ArgumentError, "#{rule.inspect} is not a Rule object"
    #         end
    #         if rule
    #           next
    #         else
    #           return false
    #         end
    #         return true
    #       end 
    #     end
  end
end