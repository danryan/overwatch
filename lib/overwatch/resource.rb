module Overwatch
  class Resource < Ohm::Model
    include Ohm::Timestamping
    include Ohm::Typecast
    include Ohm::Callbacks
    include Ohm::ExtraValidations
    
    attribute :name, String
    attribute :api_key, String

    index :name
    index :api_key
    
    list :snapshots, "Overwatch::Snapshot"
    set :resource_checks, "Overwatch::ResourceCheck"
    
    def validate
      super
      assert_present :name
      assert_unique :name
      assert_unique :api_key
    end
    
    before :create, :generate_api_key
    
    def checks
      Overwatch::ResourceCheck.find(:resource_id => self.id).map do |rc|
        Overwatch::Check[rc.check_id]
      end
    end
    
    def snapshot_range(start_at=Time.now, end_at=Time.now)
      snapshots.find(:created_at.gte => start_at, :created_at.lte => end_at)
    end
    
    def previous_update
      snapshots.order_by(:created_at.desc)[1]
    end
    
    def last_update
      snapshots.order_by(:created_at.desc)[0]
    end
    
    def run_checks
      Resque.enqueue(CheckRun, self.id.to_s)
    end
    
    def regenerate_api_key
      generate_api_key
      self.save
    end
    
    private
    
    def generate_api_key
      api_key = Digest::SHA1.hexdigest(Time.now.to_s + rand(12341234).to_s)[1..30]
      self.api_key = api_key
    end
    

     
  end # class Resource
end # module Overwatch