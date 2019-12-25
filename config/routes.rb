Rails.application.routes.draw do
  root 'articles#index'

  resources :categories
  resources :articles do
    resources :comments
  end

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
