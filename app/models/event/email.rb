class Event::Email < Event
  property :recipients, Json
  
  def run(snapshot, check, rule)
    Mail.defaults do
      delivery_method :smtp, Overwatch.config["mail"].symbolize_keys
    end
    
    mail = Mail.new
    mail.from "dan@appliedawesome.com"
    mail.to self.recipients
    mail.subject "[Overwatch] #{rule.to_s} failed on #{snapshot.resource.name}!"
    mail.body "What we checked: #{rule.to_s}\nWhat we saw: #{snapshot.data[rule.attr]}"
    mail.deliver!
    # super
  end # run

end
