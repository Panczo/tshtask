Tshtask::Application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  
  resources :users, except: [:show, :index]
  resources :money, except: [:delete, :edit, :update, :create, :new] do
     get 'refresh_rates', on: :collection
  end
  get 'report', to: 'money#report' 

  authenticated :user do
    root to: "money#index", :as => "dashboard", via: :get
  end

  root to: "home#index"
end
