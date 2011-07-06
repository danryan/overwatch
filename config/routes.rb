Overwatch::Application.routes.draw do
  mount Resque::Server.new, :at => "/resque"
  
  resources :assets do
    resources :snapshots
    resources :checks
    member do
      get 'attributes' => 'assets#attributes'
      # get 'attributes/:attribute' => 'assets#attribute' 
        # :constraints => { :attribute => /[A-Za-z0-9\._\-+]+/ }
    end
  end
  
  resources :checks do
    resources :rules
    resources :assets
    resources :events
  end
  
  resources :events do
    resources :checks
  end
  
  resources :snapshots, :only => [ :create ]
end
