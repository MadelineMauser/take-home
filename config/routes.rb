Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      patch '/subscriptions/:id/cancel', to: 'subscriptions#cancel'
      resources :customers, except: [:index, :show, :new, :create, :edit, :update, :destroy] do
        resources :subscriptions, only: [:index, :create]
      end
    end
  end
end
