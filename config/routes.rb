Rails.application.routes.draw do

  resources :todos do
    collection do
      get :v1
      get :v2
      get :v3
    end
  end

  get 'this' => "welcome#this"

  post 'pay2go/return'
  post 'pay2go/notify'

  scope :path => '/api/v1/', :module => "api_v1", :as => 'v1', :defaults => { :format => :json } do

    post "/login" => "auth#login"
    post "/logout" => "auth#logout"

    resources :topics
  end

  resources :products do
    member do
      post :buy
      post :cancel
    end
  end

  resources :orders do
    member do
      post :checkout_pay2go
    end
  end

  resources :people
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get "/ajax" => "welcome#ajax"
  get "/ajaxtest" => "welcome#ajaxtest"

  get "/ubike" => "welcome#ubike"

  resources :users

  resources :topics do
    resources :comments
    resources :likes

    member do
      post :subscribe
      post :unsubscribe
    end
  end

  namespace :admin do
    resources :orders
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'topics#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
