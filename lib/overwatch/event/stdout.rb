module Overwatch
  class Event::STDOUT < Event
    def run(snapshot, check, rule)
      puts "holy science!!"
      puts "#{rule.to_s} failed on #{snapshot.resource.name}!"
      puts "What we checked: #{rule.to_s}"
      puts "What we saw: #{snapshot.data[rule.attr]}"
      super
    end
  end
end