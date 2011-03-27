# Alerts

Alerts are a powerful function of Monitaur. While many monitoring applications' alert triggers are very basic ("if n is x"), Monitaur allows chain-able triggers. If you're familiar with email client filters, Monitaur's alert triggers act in the same way.

## Workflow

A data point is the central functioning piece of information in Monitaur. It belongs to both a node (`web-server`) and a metric (`load_averages`), and encapsulates a key (`one_minute`) and a value for that key (`1.01`). Every time a data point is recorded, it undergoes an inspection by the server to determine whether it is within acceptable bounds.

## Example


    Given a node "web-server" with IP address "10.0.1.120"
    And a metric "load_average"
    When I create a new data point with key "one_minute" and value "1.01"
    Then the node should have 1 data point
    And the metric should have 1 data point
    
    node = Node.create(:name => "web-server", :ip_address => "10.0.1.120")
    metric = Metric.create(:name => "load_average")
    
    load_average = DataPoint.create(
      :key => "one_minute",
      :value => "1.0.1",
      :node => node,
      :metric => metric
    )
    
    node.data_points.count.should == 1
    metric.data_points.count.should == 1
    
## Conditions

### Greater than
#### Confirms

    gt
    greater_than
    is_greater_than

#### Negates
    
    not_gt
    not_greater_than
    is_not_greater_than
    
### Less than
#### Confirms

    lt
    less_than
    is_less_than
    

#### Negates
    
    not_lt
    not_less_than
    is_not_less_than
    
### Equal to
#### Confirms

    eq
    equal_to
    is_equal_to
    or_equal_to

#### Negates

    not_eq
    not_equal_to
    is_not_equal_to
    or_not_equal_to

### Is
#### Confirms
    
    is

#### Negates

    is_not
    not

Combine these chainable methods, and you have a very powerful interface for determining whether a data point should trigger an alert:

    load_average.greater_than("1.5").or_equal_to("1.0")
    
If at any point in the chain the result returns false, the check passes



It starts with
alert = Alert.new

alert(:key).is_greater_than("2").and()