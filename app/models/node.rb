class Node
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, :type => String
  field :ip_address, :type => String
  
  validates_presence_of :name, :ip_address
  
  embeds_many :metrics, :dependent => :destroy
end
