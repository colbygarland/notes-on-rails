Rails.application.routes.draw do
  root 'notes#index'

  resources :notes do
    resources :comments
  end
end
