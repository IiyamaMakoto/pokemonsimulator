Rails.application.routes.draw do
  root 'calc#index'
  resources :calc, only: :index do
    collection do
      get :search
      get :result
    end
  end
end
