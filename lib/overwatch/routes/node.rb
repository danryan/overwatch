module Overwatch
  class Application < Sinatra::Base


   get '/nodes/?' do
      nodes = Overwatch::Node.all
      if nodes.size == 0
        halt 404
      else
        nodes.to_json
      end
    end # GET index

    get '/nodes/:name/?' do |name|
      node = Overwatch::Node.where(:name => name).first
      if node
        status 200
        node.to_json
      else
        status 404
        body "Node not found".to_json
      end
    end # GET show

    post '/nodes/?' do
      data = JSON.parse(request.body.read)
      node = Node.new(:name => data['name'])
      if node.save
        node.to_json
      else
        status 422
        node.errors.to_json
      end
    end # POST

    delete '/nodes/:name/?' do |name|
      node = Overwatch::Node.where(:name => name).first
      if node
        if node.delete
          status 204
          body node.to_json
        else
          status 409
          node.errors.to_json
        end
      else
        halt 404
      end
    end # DELETE

    get '/nodes/:name/regenerate_api_key' do |name|
      node = Overwatch::Node.where(:name => name).first
      if node
        if node.regenerate_api_key
          status 200
          body node.to_json
        else
          status 444
          node.errors.to_json
        end
      else
        halt 404
      end
    end # REGEN API KEY
    
    
    post '/nodes/:api_key/?' do
      data = JSON.parse(request.body.read)
      node = Node.where(:api_key => params['api_key']).first
      snapshot = node.snapshots.new(:raw_data => data)
      if snapshot.save
        status 200
        snapshot.to_json(:only => [ :_id, :created_at ])
      else
        status 422
        snapshot.errors.to_json
      end
    end
    
  end # Application
end # Overwatch