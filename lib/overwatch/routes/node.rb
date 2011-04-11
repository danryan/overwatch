module Overwatch
  class Application < Sinatra::Base

   get '/nodes/?' do
      nodes = Overwatch::Node.all
      if nodes.size == 0
        halt 404
      else
        nodes.map { |n| n.to_hash }.to_json
      end
    end # GET index

    get '/nodes/:name/?' do |name|
      node = Overwatch::Node.find(:name => name).first
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
        format_errors(node).to_json
      end
    end # POST

    delete '/nodes/:name/?' do |name|
      node = Overwatch::Node.find(:name => name).first
      if node
        if node.delete
          status 204
          body node.to_json
        else
          status 409
          body format_errors(node).to_json
        end
      else
        status 404
        body "Node not found".to_json
      end
    end # DELETE

  end # Application
end # Overwatch