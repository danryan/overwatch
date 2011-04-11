module Overwatch
  class Application < Sinatra::Base

    get '/nodes/:name/snapshots?' do |name|
      node = Node.find(:name => name).first
      snapshots = node.snapshots
      snapshots.map { |n| n.to_hash }.to_json
    end # GET index

    post '/nodes/:name/snapshots/?' do |name|
      data = JSON.parse(request.body.read)
      node = Node.find(:name => name).first
      snapshot = Snapshot.new(:data => data, :node => node)
      
      if snapshot.save
        snapshot.to_json
      else
        status 422
        format_errors(snapshot).to_json
      end
    end # POST
    
    get '/nodes/:name/snapshots/:id/?' do |name, id|
      node = Overwatch::Node.find(:name => name).first
      snapshot = node.snapshots[id]
      if snapshot
        status 200
        snapshot.data.to_json
      else
        status 404
        body "Snapshot not found".to_json
      end
    end # GET show

    delete '/nodes/:name/snapshots/:id/?' do |name, id|
      snapshot = Snapshot[id]
      if snapshot
        if snapshot.delete
          status 204
          snapshot.to_json
        else
          status 409
          format_errors(snapshot).to_json
        end
      else
        status 404
        body "Snapshot not found".to_json
      end
    end # DELETE

  end # Application
end # Overwatch