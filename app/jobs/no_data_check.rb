class NoDataCheck
  @queue = :no_data_checks
  
  def self.perform(resource)
    resource = Overwatch::Resource.get(resource['id'])
    if resource.last_update && 
      resource.snapshots.count > 0 &&
      resource.last_update.created_at > 5.minutes.ago
      system "touch /tmp/crap.txt"
    else
      Resque.enqueue_in(5.minutes, NoDataCheck, resource)
    end
  end
  
end