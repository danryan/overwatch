module Overwatch
  class Event
    include Mongoid::Document
    include Mongoid::Timestamps

    references_and_referenced_in_many :checks, :class_name => "Overwatch::Check"
    
    def run(snapshot, check, resource)
    end
  end # Event
end # Overwatch