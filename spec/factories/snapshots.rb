# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.sequence :random_num do |n|
  sprintf("%01d", n) 
end

Factory.define :snapshot do |f|
  f.asset { Factory(:asset) }
  f.raw_data {{ 
    :cheeses => {
      :swiss => rand(10),
      :gouda => rand(10),
      :provolone => rand(10)
    }
  }}
end