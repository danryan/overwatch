class CheckRun
  @queue = :checks
  
  def self.perform(asset_id)
    asset = Asset.get(asset_id)
    asset.checks.each do |check|
      check.run(asset.last_update)
    end
  end
end