Rails.application.routes.draw do

  devise_for :users
  root to: "products#index"

  get '/know_your_role', to: 'products#know_your_role'#non-admin deny page


  get '/products', to: 'products#index'
  get '/products/search', to: 'products#search'
  get '/products/new', to: 'products#new'
  get '/products/ordered_price_asc', to: 'products#products_ordered_price_asc'
  get '/products/ordered_price_desc', to: 'products#products_ordered_price_desc'
  get '/products/random', to: 'products#random'
  post '/products', to: 'products#create'
  get '/products/:id/edit', to: 'products#edit'
  get '/products/:id', to: 'products#show'
  patch '/products/:id', to: 'products#update'
  delete '/products/:id', to: 'products#destroy'

  post '/orders/create', to: 'orders#create'
  get '/orders/:id', to: 'orders#show'

  get '/carted_products', to: 'carted_products#index'
  post 'carted_products/create', to: 'carted_products#create'
  delete '/carted_products/:id', to: 'carted_products#destroy'


  resources :products
  resources :suppliers

  # :foo is a wildcard param passed via URL
  #can also get pass a record id as wildcard param via URL:
  #get '/:id', to: 'products#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
