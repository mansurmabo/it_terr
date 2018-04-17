Rails.application.routes.draw do
  root to: "users#index"

  resources :posts, only: [:index, :create] do
    post :estimate, on: :member
    get :ip_addresses, on: :collection
  end
end
