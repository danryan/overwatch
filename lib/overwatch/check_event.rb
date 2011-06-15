module Overwatch
  class CheckEvent < Ohm::Model
    include Ohm::Timestamping
    include Ohm::Typecast
    include Ohm::Callbacks
    include Ohm::ExtraValidations
    
    reference :check, "Overwatch::Check"
    reference :event, "Overwatch::Event"
    
    index :check
    index :event
  end
end
    