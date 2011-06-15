module Overwatch
  class Check < Ohm::Model
    include Ohm::Timestamping
    include Ohm::Typecast
    include Ohm::Callbacks
    include Ohm::ExtraValidations
    
    set :resource_checks, "Overwatch::ResourceCheck"
    set :check_events, "Overwatch::CheckEvent"
    set :rules, "Overwatch::Rule"
    
    def resources
      Overwatch::ResourceCheck.find(:check_id => self.id).map do |rc|
        Overwatch::Resource[rc.resource_id]
      end
    end
    
    def events
      Overwatch::CheckEvent.find(:check_id => self.id).map do |rc|
        Overwatch::Event[rc.event_id]
      end
    end
    
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