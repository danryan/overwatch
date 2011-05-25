module Overwatch
  class Event::WebHook < Event
    field :url, :type => Array
    field :data, :type => Hash
    field :headers, :type => Hash
    
    def run(snapshot, check, rule)
      res = RestClient.post self[:url], self[:data], self[:headers]
      # res.body
    end # run
    
  end # Event::Email
end # Overwatch