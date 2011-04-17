module Overwatch
  class Event
    include Mongoid::Document
    include Mongoid::Timestamps

    references_and_referenced_in_many :checks, :class_name => "Overwatch::Check"
    
    field :body, :type => String
    field :recipients, :type => Array
    
    def run
      
    end
  end # Event
end # Overwatch