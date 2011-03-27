# Monitaur

A monitoring service you can bring home to Mom™

Node
metric.data_points.map(&:node).uniq

|

DataPoint

|

Metric
node.data_points.map(&:metric).uniq

* How does a data point enter the system?




A datapoint comes in from the client through the API, and looks something like this:


{
  :data_point => {
    :key => "key",
    :value => "value",
    :metric => "key",
    :node => "uuid"
  }
}


or (load average)

{
  :data_point => {
    :key => "One Minute",
    :value => "1.01",
    :metric => "load-average",
    :node => "71140ea02837012e15ee0025bcdd0280"
  }
}


## How will plugins work?

* Client will `git clone` latest copies of plugins
* For each plugin, client will IO.read(file) and 
* @plugins << Plugin.new.instance_eval(file)
* @plugins.each { |plugin| plugin.phone_home }
  