Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :cities
    resources :states do
      resources :cities
    end
  end
  
  namespace :api, :defaults => { :format => 'json' } do
    namespace :v1 do
      resources :cities
      resources :states do
        resources :cities, only: [:index, :show]
      end
      
      get 'countries/:country_id/cities', to: 'cities#index', as: 'country_cities'
    end
  end

  get '/addresses(/*cep)', to: 'addresses#show', as: :address_show
end
