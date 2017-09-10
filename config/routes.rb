Rails.application.routes.draw do
  
  


  resources :brands
  resources :colors
  resources :subcategories
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
  match '/payu_callback' => 'payments#payu_return', :via => [:get, :post], :as => 'payments_payu_return'
  match '/product_search' => 'home#product_search', :via => [:get, :post], :as => 'product_search'
  get  'payments/mypayment'
  get  '/cod_confirmation' => 'payments#cod_confirmation', as: 'cod_confirmation'
  get  '/place_oreder' => 'payments#place_oreder', as: 'place_oreder'
  # You can have the root of your site routed with "root"
  root 'home#index'
  get  '/product_list' => 'home#product_list', as: 'product_list'
  get  '/filter_listing' => 'home#filter_listing', as: 'filter_listing'
  get  '/productfilter_listing' => 'home#productfilter_listing', as: 'productfilter_listing'
  
  
  get  'home/product_detail'
  get  'home/product_update'
  # get  'home/product_listing'
  # get  'orders/order_success'
  get  'home/check_out'
  get  'home/my_order'
  post 'users/register', to: 'users#register', as: :registration
  post 'users/save_address', to: 'users#save_address', as: :save_address
  post 'users/login', to: 'users#login', as: :login
  get 'users/sign_out', to: 'users#sign_out', as: :sign_out
  get 'users/my_profile', to: 'users#my_profile', as: :profile
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  resources :line_items do
    get 'decrease', on: :member
    get 'increase', on: :member
  end
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
