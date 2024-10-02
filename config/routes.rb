Rails.application.routes.draw do
  devise_for :users
  root 'students#index'
  resources :students, only:[:index, :update, :create, :destroy] do
    collection do 
      get :new_modal
    end 
    member do 
      get :edit_modal
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
