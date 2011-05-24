module Overwatch
  class Node
    include Mongoid::Document
    include Mongoid::Timestamps
    
    field :name, :type => String
    field :api_key, :type => String
    
    index :name
    
    references_many :snapshots, :class_name => "Overwatch::Snapshot", :validate => false
    references_and_referenced_in_many :checks, :class_name => "Overwatch::Check"
    
    validates_presence_of :name, :api_key
    validates_uniqueness_of :name
    
    before_validation :generate_api_key, :on => :create
    
    def snapshot_range(start_at=Time.now, end_at=Time.now)
      snapshots.where(:created_at.gte => start_at, :created_at.lte => end_at)
    end
    
    def previous_update
      snapshots.order_by(:created_at.desc)[1]
    end
    
    def last_update
      snapshots.order_by(:created_at.desc)[0]
    end
    
    def run_checks
      Resque.enqueue(CheckRun, self._id.to_s)
    end
    
    def regenerate_api_key
      generate_api_key
      self.save
    end
    
    private
    
    def generate_api_key
      api_key = Digest::SHA1.hexdigest(Time.now.to_s + rand(12341234).to_s)[1..30]
      self[:api_key] = api_key
    end
    

     
  end # class Node
end # module Overwatch