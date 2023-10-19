Rails.application.routes.draw do
  # Configuración de rutas de Devise
  devise_for :users, controllers: { registrations: "users/registrations" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  root "users#index"
end
