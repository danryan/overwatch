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
  end
end