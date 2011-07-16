snapshots:1:data:load_average

snapshots:

snapshots:1 
 * keys - set of all attribute keys
 
 
 
 asset:1:load_average.one_minute:hourly #=> list
 - redis.rpush("asset:1:load_average.one_minute:day", "0.91")
 - redis.ltrim("asset:1:load_average.one_minute:day", 0, 1440 )
 
 
snapshot:2345:data => Hash
asset:id:attribute => Sorted set

daily cron that converts all asset:id:attribute into daily hash


asset = Asset.get(2)
asset.attribute_keys.each do |attr|
  timestamp = Time.now.strftime("%Y%m%d")
  attr_hash = {
    :min => asset.min(attribute),
    :max => asset.max(attribute),
    :median => asset.median(attribute),
    :average => asset.average(attr)
  }
  
  hash = Hash[*$redis.zrange(zset, :with_scores => true)] 
  $redis.hmset "asset:#{asset.id}:#{timestamp}:#{attribute}"
  $rediz.zremrangebyscore zset -inf +inf
  
asset = Asset.get(2)
asset.attribute_keys.each do |attribute|
  timestamp = Time.now.strftime("%Y%m%d")
  attr_hash = {
    :min => asset.min(attribute),
    :max => asset.max(attribute),
    :median => asset.median(attribute),
    :average => asset.average(attribute)
  }

  $redis.hmset "asset:#{asset.id}:#{attribute}:#{timestamp}"
  $redis.zremrangebyscore "asset:#{asset.id}:#{attribute}" -inf +inf
end


Overwatch::Application.routes.draw do 
  match '/events', :to => Overwatch.config.events.app
  match '/checks', :to => Overwatch.config.checks.app
end




