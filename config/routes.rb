Rails.application.routes.draw do
  resources :mappings
  resources :fields
  resources :synchronizations do
    member do
      put 'map'
      get 'map'
      get 'save_localizable'
    end
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
