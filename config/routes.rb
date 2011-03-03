Lansing::Application.routes.draw do
  resources :nodes do
    resources :metrics do
      member do
        get 'data'
      end
    end
  end
end
