Overwatch::Application.routes.draw do
  
  resources :assets do
    resources :snapshots
    resources :checks
  end
  
  resources :checks do
    resources :rules
    resources :assets
    resources :events
  end
  
  resources :events do
    resources :checks
  end
  
end
