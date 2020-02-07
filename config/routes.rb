Rails.application.routes.draw do
  root 'calc#index'
  resources :calc, only: :index do
    collection do
      get :search
    end
    member do
      get :set_left
      get :set_right
    end
  end
end
