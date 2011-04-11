module Overwatch
  class Snapshot < Ohm::Model
    include Ohm::Timestamping
    include Ohm::Typecast
    include Ohm::Callbacks
    include Ohm::ExtraValidations
    
    attribute :data, Hash
    reference :node, Node
    
    # def to_hash
    #   super.merge(:data => data)
    # end # to_hash
    
  end
end