module Overwatch
  class Event::WebHook < Event
    attribute :url, Array
    attribute :data, Hash
    attribute :headers, Hash
    
    def run(snapshot, check, rule)
      res = RestClient.post self.url, self.data, self.headers
      # res.body
    end # run
    
  end # Event::Email
end # Overwatch