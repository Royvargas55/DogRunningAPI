Rails.application.routes.draw do
    resources :dogs, only: [:index, :show, :create, :update, :destroy] do
        resources :reservations
    end
    resources :reservations
    get '/dog', to: 'dogs#search'
    
    get '/breeds', to: 'breeds#index'
    get '/breed', to: 'breeds#search'
end
