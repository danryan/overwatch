# Create default metrics

[ "Load Averages", "Disk Usage", "Memory Usage", "Swap Usage" ].each do |metric|
  Metric.find_or_create_by(:name => metric)
end