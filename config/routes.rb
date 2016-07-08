Tshtask::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  
  resources :users, except: [:show, :index]
  resources :money, except: [:delete, :edit, :update, :create, :new] do
     get 'refresh_rates', on: :collection
  end

  root :to => "home#index"
end
