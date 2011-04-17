module Overwatch
  class Event::STDOUT < Event
    def run(check, rule)
      puts "holy jesus!"
      puts "#{check.inspect}"
      puts "#{rule.inspect}"
      super
    end
  end
end