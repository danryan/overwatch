Lansing::Application.routes.draw do
  resources :nodes do
    resources :metrics do
      resources :data_points, :as => :data, :path => :data
      # member do
      #         get 'data' => 'metrics#retrieve_data'
      #         post 'data' => 'metrics#process_data'
      #       end
    end
  end
end
