class Event::HTTP < Event
  property :url, String
  property :action, String
  property :data, Json
  property :headers, Json
  property :content_type, String
  
  # def run(snapshot, check, rule)
  #       to_content_type = "to_#{self.content_type.to_s}"
  #       headers.merge!(:content_type => self.content_type)
  #       headers.merge!(:accept => self.content_type)
  #       case self.action.to_sym
  #       when :get
  #         RestClient.get(self.url)
  #       when :post
  #         RestClient.post self.url, self.data.send(to_content_type), self.headers, :content_type => self.content_type.to_sym
  #       when :put
  #         RestClient.put self.url, self.data.send(to_content_type), self.headers
  #       end
  #        # self.url, self.data, self.headers
  #       # res.body
  #     end # run


end
