module Overwatch
  class Application < Sinatra::Base

    get '/nodes/:name/snapshots/?' do |name|
      node = Node.where(:name => name).first
      snapshots = node.snapshots
      snapshots.to_json(:only => [ :_id, :created_at ])
    end # GET index

    post '/nodes/:name/snapshots/?' do |name|
      data = JSON.parse(request.body.read)
      node = Node.where(:name => name).first
      snapshot = node.snapshots.new(:data => data)
      
      if snapshot.save
        snapshot.to_json
      else
        status 422
        snapshot.errors.to_json
      end
    end # POST
    
    get '/nodes/:name/snapshots/:id/?' do |name, id|
      node = Overwatch::Node.where(:name => name).first
      snapshot = node.snapshots.find(id)
      if snapshot
        status 200
        snapshot.to_json
      else
        halt 404
      end
    end # GET show

    delete '/nodes/:name/snapshots/:id/?' do |name, id|
      node = Overwatch::Node.where(:name => name).first
      snapshot = node.snapshots.find(id)
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

  end # Application
end # Overwatch