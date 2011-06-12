module Overwatch
  class Check
    include Mongoid::Document
    
    references_and_referenced_in_many :resources, :class_name => "Overwatch::Resource"
    references_and_referenced_in_many :events, :class_name => "Overwatch::Event"
    references_many :rules, :class_name => "Overwatch::Rule"
    
    def run(snapshot)
      rules.each do |rule|
        if rule.run(snapshot)
          next
        else
          fire!(snapshot, rule)
          return false
        end
      end
      return true
    end
    
    def fire!(snapshot, rule)
      events.each do |event|
        event.run(snapshot, self, rule)
      end
    end
  end
end