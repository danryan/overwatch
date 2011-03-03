Lansing::Application.routes.draw do
  resources :nodes do
    resources :metrics
  end
end
