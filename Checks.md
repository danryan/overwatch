# A new record is created in Overwatch::Storage and it sends a JSON payload containing the snapshot to check, the attribute to check for. Checks are pre-defined in the system, but can also be ad-hoc checks.
# 
# 
# { 
#   "asset" => "asset-name"
#   "data" => ...
# }
# 
# Find all global checks
# Find all checks defined for 'asset-name'
# Compile the list of checks, and process each

# Conditions:
# Overwatch::Check::Condition
# Overwatch::Check::Condition::LessThan
# Overwatch::Check::Condition::GreaterThan
# Overwatch::Check::Condition::Is
# Overwatch::Check::Condition::IsNot

# Adapters:
# Overwatch::Event::Adapter::Default
# Overwatch::Event::Adapter::PagerDuty

Overwatch.setup do |config|
  config.checks do |checks|
    # block is an instance of Overwatch::Config.new
    checks.url = "https://10.0.1.10" # default: localhost
    checks.queue = "production" # default: resque:checks
    checks.adapter = Overwatch::Check::Adapter::Default
  end
  
  config.events do |events|
    # block is an instance of Overwatch::Config.new
    events.url = "https://eventapp.com" # default: localhost
    events.adapter = Overwatch::Event::Adapter::EventApp # default: Overwatch::Event::Adapter::Default
    events.enabled << [ Overwatch::Event::Email, Overwatch::Event::HTTP, Overwatch::Event::XMPP ]
  end
  
  config.storage do |storage|
    # block is an instance of Overwatch::Config.new
    storage.url = "https://10.0.1.11" # default: localhost
    storage.adapter = Overwatch::Storage::Adapter::Default # default: Overwatch::Storage::Adapter::Default
    storage.retain "1 year"
  end
end

check = Check.first(:name => payload['asset'])

{
  "asset": "asset-name",
  "rules": [
    {
      "attribute": "load_average.one_minute",
      "condition": "less_than",
      "value": "5.0"
    },
    {
      "attribute": "load_average.five_minutes",
      "condition": "less_than",
      "value": "10.0"
    },
  ],
  "events": [ 1, 3, 5, 6 ]
}


# Returns:

{ 
  "asset": "asset-name",
  "rules": [
    "passed": [
      {
        "attribute": "load_average.one_minute",
        "condition": "less_than",
        "value": "5.0"
      }
    ],
    "failed": [
      {
        "attribute": "load_average.five_minutes",
        "condition": "less_than",
        "expected": "10.0",
        "got": "15.0",
        "event": "1"
      }
    ]
  ]
}

if @check.failed > 0
  @check.failed.each do |failed|
    @check.events.each do |event|
      event.run(failed)
    end
  end
end

module Overwatch::Event::Adapter
  class Default
    def initialize(options = {})
      super
      @payload   = Yajl.load(payload)
      @attribute = @payload['attribute']
      @condition = @payload['condition']
      @expected  = @payload['expected']
      @got       = @payload['got']
      @event     = @payload['event']
      @url       = Overwatch.config.events.url
      @path      = "/events/#{}"
    end
    
    def run(payload)
    end
    
    def post("#{@url}/events)
      RestClient.post("#{@url}/events/#")
  end
end

class Event
  
  def initialize()
    
  def call(check)
    
    
end