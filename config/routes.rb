Rails.application.routes.draw do
  
  devise_for :admins
  # devise_for :admins, path: 'admins'
  namespace :myadmin do
  get 'admin/index'
  end

  resources :orders
  get 'users/new'

  get 'home/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  get  'home/product_list'
  get  'home/product_detail'
  # get  'orders/order_success'
  get  'home/check_out'
  get  'home/my_order'
  post 'users/register', to: 'users#register', as: :registration
  post 'users/login', to: 'users#login', as: :login
  get 'users/sign_out', to: 'users#sign_out', as: :sign_out
  get 'users/my_profile', to: 'users#my_profile', as: :profile
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  resources :line_items
  resources :carts
  resources :products
  resources :categories
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
  #     #   end
end
