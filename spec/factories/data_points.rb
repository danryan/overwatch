# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :data_point do |d|
  d.key "one_minute"
  d.value "1.01"
  d.association :metric, :factory => :metric
  d.association :node, :factory => :node
end