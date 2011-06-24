class SnapshotReaper
  @queue = :snapshot_reapers

  def self.perform(snapshot)
    snapshot = Overwatch::Snapshot.get(snapshot['id'])
    snapshot.destroy
  end
end