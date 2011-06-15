module Overwatch
  class Application < Sinatra::Base

   get '/resources/?' do
      resources = Overwatch::Resource.all
      if resources.size == 0
        halt 404
      else
        resources.to_json
      end
    end # GET index

    get '/resources/:name/?' do |name|
      resource = Overwatch::Resource.find(:name => name).first
      if resource
        status 200
        resource.to_json
      else
        status 404
        body "Resource not found".to_json
      end
    end # GET show

    post '/resources/?' do
      data = JSON.parse(request.body.read)
      resource = Resource.new(:name => data['name'])
      if resource.save
        resource.to_json
      else
        status 422
        resource.errors.to_json
      end
    end # POST

    delete '/resources/:name/?' do |name|
      resource = Overwatch::Resource.find(:name => name).first
      if resource
        if resource.delete
          status 204
          body resource.to_json
        else
          status 409
          resource.errors.to_json
        end
      else
        halt 404
      end
    end # DELETE

    get '/resources/:name/regenerate_api_key' do |name|
      resource = Overwatch::Resource.find(:name => name).first
      if resource
        if resource.regenerate_api_key
          status 200
          body resource.to_json
        else
          status 444
          resource.errors.to_json
        end
      else
        halt 404
      end
    end # REGEN API KEY
    
    
    post '/resources/:api_key/?' do
      data = JSON.parse(request.body.read)
      resource = Resource.find(:api_key => params['api_key']).first
      snapshot = resource.snapshots.new(:raw_data => data)
      if snapshot.save
        status 200
        snapshot.to_json(:only => [ :id, :created_at ])
      else
        status 422
        snapshot.errors.to_json
      end
    end
    
    # All checks associated with a resource
    get '/resources/:name/check/?' do |name|
      checks = Overwatch::Resource.find(:name => name).first.resources
      if checks.size == 0
        halt 404
      else
        checks.to_json
      end
    end
    
  end # Application
end # Overwatch