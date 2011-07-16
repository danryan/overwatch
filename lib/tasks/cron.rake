namespace :overwatch do
  task :cron => :environment do
    Asset.all.each do |asset|
      attr_hash = {}
      timestamp = Time.now.utc.strftime("%Y%m%d").to_time.to_i
      asset.attribute_keys.each do |attribute|
        puts attribute
        zset = "asset:#{asset.id}:#{attribute}"
        attr_hash[attribute] = {
          :first => asset.first(attribute),
          :last => asset.last(attribute)
          # :min => asset.min(attribute),
          # :max => asset.max(attribute),
          # :median => asset.median(attribute),
          # :average => asset.average(attribute)
        }
        $redis.zremrangebyscore zset, '-inf', '+inf'
      end
      puts attr_hash.inspect
      $redis.set "asset:#{asset.id}:#{timestamp}", Yajl.dump(attr_hash)
    end

    # Playing around with storing daily values in a Redis hash. 
    #
    # Asset.all.each do |asset|
    #   asset.attribute_keys.each do |attribute|
    #     zset = "asset:#{asset.id}:#{attribute}"
    #     timestamp = Time.now.utc.strftime("%Y%m%d").to_time.to_i
    #     attr_hash = {
    #       :first => asset.first(attribute),
    #       :last => asset.last(attribute),
    #       :min => asset.min(attribute),
    #       :max => asset.max(attribute),
    #       :median => asset.median(attribute),
    #       :average => asset.average(attribute)
    #     }
    # 
    #     $redis.mapped_hmset "#{zset}:#{timestamp}", attr_hash
    #     $redis.zremrangebyscore zset, '-inf', '+inf'
    #   end
    # end
  end
end
    