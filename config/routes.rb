Overwatch::Application.routes.draw do
  get "charts/index"

  get "charts/show"

  get "charts/new"

  get "charts/edit"

  mount Resque::Server.new, :at => "/resque"
  
  resources :assets do
    resources :snapshots
    resources :checks
    member do
      get 'attributes' => 'assets#attributes'
      get 'sub_attributes/:attribute' => 'assets#sub_attributes'
      # get 'attributes/:attribute' => 'assets#attribute' 
        # :constraints => { :attribute => /[A-Za-z0-9\._\-+]+/ }
    end
    resources :charts
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
