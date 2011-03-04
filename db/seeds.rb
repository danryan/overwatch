node1 = Node.create(:name => "Foo Server", :ip_address => "10.0.1.120")
node2 = Node.create(:name => "Bar Server", :ip_address => "10.0.1.129")

node1 = Node.where(:name => "Foo Server").first
node2 = Node.where(:name => "Bar Server").first

node1.metrics << Metric.find_or_create_by(:name => "Load Average")
node2.metrics << Metric.find_or_create_by(:name => "Load Average")
node1.metrics << Metric.find_or_create_by(:name => "Disk Usage")
node2.metrics << Metric.find_or_create_by(:name => "Disk Usage")

i = 1.0
while i < 100.0
  node1.metrics.where(:key => "load-average").first.data_points.create(
    :key => "One Minute", 
    :value => i,
    :node => node1
  )
  node2.metrics.where(:key => "load-average").first.data_points.create(
    :key => "One Minute", 
    :value => i,
    :node => node2
  )
  i += 1.0
end

100.times do 
  node1.metrics.where(:key => "disk-usage").first.data_points.create(
    :key => "Used",
    :value => 50,
    :node => node1
  )
  node2.metrics.where(:key => "disk-usage").first.data_points.create(
    :key => "Used",
    :value => 50,
    :node => node2
  )
end
