Rails.application.routes.draw do
  root to: "users#index"

  resources :posts, only: [:index, :create] do
    post :estimate, on: :member
  end

end
