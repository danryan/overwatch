module Overwatch
  class Application < Sinatra::Base

   get '/checks/?' do
      checks = Overwatch::Check.all
      if checks.size == 0
        halt 404
      else
        checks.to_json
      end
    end # GET index

    get '/checks/:id/?' do |id|
      check = Overwatch::Check[id]
      if check
        status 200
        check.to_json
      else
        status 404
        body "Check not found".to_json
      end
    end # GET show

    post '/checks/?' do
      data = JSON.parse(request.body.read)
      check = Check.new
      if check.save
        check.to_json
      else
        status 422
        check.errors.to_json
      end
    end # POST

    delete '/checks/:id/?' do |id|
      check = Overwatch::Check[id]
      if check
        if check.delete
          status 204
          body check.to_json
        else
          status 409
          check.errors.to_json
        end
      else
        halt 404
      end
    end # DELETE
    
    get '/checks/:id/resources/?' do |id|
      resources = Overwatch::Check[id].resources
      if resources.size == 0
        halt 404
      else
        resources.to_json
      end
    end
    
  end # Application
end # Overwatch