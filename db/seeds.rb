node = Node.create(:name => "Foo Server", :ip_address => "10.0.1.120")

i = 1.0
j = 1.0
while i < 100.0
  node.metrics.create(:name => "load", :data => { :one_min => i })
  node.metrics.create(:name => "disk_usage", :data => { :percentage => j } )
  i += 1.0
  j += 1.0
end