# class Metric
#   include DataMapper::Resource
# 
#   property :id, Serial
#   property :created_at, DateTime
#   property :updated_at, DateTime
#   property :name, String
#   property :units, String
#   property :attribute, String
#   
#   belongs_to :chart
#   # 
#   # def to_json
#   #   {
#   #     :label => self.label,
#   #     :units => self.units,
#   #     :data => self.chart.asset.values_for("attribute")
#   #   }
#   # end
# end
