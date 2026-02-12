Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Root path - redirects to posts index
  root "posts#index"

  # RESTful routes for posts (blog articles)
  # This creates routes for: index, show, new, create, edit, update, destroy
  resources :posts

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check
end
