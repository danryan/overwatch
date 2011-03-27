class MetricsController < InheritedResources::Base
  respond_to :html, :json
  belongs_to :node
end
