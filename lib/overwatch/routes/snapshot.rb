module Overwatch
  class Application < Sinatra::Base
    
    get '/resources/:name/snapshots/?' do |name|
      resource = Resource.where(:name => name).first
      dates = {}
      dates[:start_at] = params[:start_at] || (DateTime.now - 1.hour)
      dates[:end_at] = params[:end_at] || DateTime.now
      snapshots = resource.snapshots.where(
        :created_at.gte => params['start_at'] || (DateTime.now - 1.month),
        :created_at.lte => params['end_at'] || DateTime.now)
      if params['attribute']
        attr = params['attribute']
        results = snapshots.inject([]) do |ret, snap|
          ret << { :_id => snap[:_id], :created_at => snap[:created_at], :attribute => attr, :value => snap.data[attr] }
        end
        results.to_json(:only => [ :_id, :created_at, :attribute, :value ])
      else
        snapshots.to_json(:only => [ :_id, :created_at ])
      end
    end # GET index

    post '/resources/:name/snapshots/?' do |name|
      resource = Resource.where(:name => name).first
      snapshot = resource.snapshots.new(:raw_data => request.body.read)
      
      if snapshot.save
        # body resquest.body.read.to_json
        snapshot.to_json
      else
        status 422
        snapshot.errors.to_json
      end
    end # POST
    
    get '/resources/:name/snapshots/:id/?' do |name, id|
      resource = Overwatch::Resource.where(:name => name).first
      snapshot = resource.snapshots.find(id)
      if snapshot
        status 200
        snapshot.to_json
      else
        halt 404
      end
    end # GET show

    delete '/resources/:name/snapshots/:id/?' do |name, id|
      resource = Overwatch::Resource.where(:name => name).first
      snapshot = resource.snapshots.find(id)
      if snapshot
        if snapshot.delete
          status 204
          snapshot.to_json
        else
          status 409
          snapshot.errors.to_json
        end
      else
        halt 404
      end
    end # DELETE
    
    get '/resources/:name/snapshots/:id/data/?' do |name, id|
      resource = Resource.where(:name => name).first
      snapshot = resource.snapshots.find(id)
      if snapshot
        status 200
        snapshot.data.to_json
      else
        halt 404
      end
    end

  end # Application
end # Overwatch