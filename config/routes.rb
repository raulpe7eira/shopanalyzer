Rails.application.routes.draw do
  devise_for :users
  resources :sales, :except => :show do
    get :import, on: :collection
    post :upload, on: :collection
  end
  resources :products, :except => :show
  resources :suppliers, :except => :show
  resources :shoppers, :except => :show
  root 'sales#index'
end
