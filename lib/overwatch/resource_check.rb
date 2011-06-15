module Overwatch
  class ResourceCheck < Ohm::Model
    include Ohm::Timestamping
    include Ohm::Typecast
    include Ohm::Callbacks
    include Ohm::ExtraValidations
    
    reference :resource, "Overwatch::Resource"
    reference :check, "Overwatch::Check"
    
    index :resource
    index :check
    
  end
end