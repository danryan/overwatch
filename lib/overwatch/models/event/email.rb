module Overwatch
  class Event::Email < Event
    def run(check, rule)
      Mail.defaults do
        delivery_method :smtp, {
          :address => "smtp.gmail.com",
          :port => 587,
          :domain => "appliedawesome.com",
          :user_name => "dan@appliedawesome.com",
          :password => "Bos9eeCa",
          :authentication => "plain",
          :enable_starttls_auto => true
        }
      end
      mail = Mail.new
      mail.from "dan@appliedawesome.com"
      mail.to self.recipients
      mail.subject "Check failed! #{rule.to_s}"
      mail.body "#{rule.inspect}"
      mail.deliver!
      # super
    end # run
    
  end # Event::Email
end # Overwatch