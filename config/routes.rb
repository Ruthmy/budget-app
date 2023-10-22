Rails.application.routes.draw do
  # Configuración de rutas de Devise
  devise_for :users, controllers: { registrations: "users/registrations" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  # Defines the route for "splash/index"
  get "/splash/index", to: "splash#index"

  # Defines RESTful routes
  resources :categories do
    resources :transactions, only: [:index, :new, :create]
  end
end
