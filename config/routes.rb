Rails.application.routes.draw do

  root to: 'welcome#index'

  #devise_for :users
  devise_for :users, controllers: {
        registrations: 'users/registrations'
  }
  namespace :users do
    get 'favorite_courses' => 'favorite_courses#show'
    post 'favorite_courses' => 'favorite_courses#create'
    delete 'favorite_courses' => 'favorite_courses#destroy'
    post 'favorite_courses/export' => 'favorite_courses#export'

    get 'passed_courses' => 'passed_courses#show'
    post 'passed_courses' => 'passed_courses#create'
    delete 'passed_courses' => 'passed_courses#destroy'

    get 'time_filter' => 'time_filter#show'
    patch 'time_filter' => 'time_filter#update'
    put 'time_filter' => 'time_filter#update'
    post 'time_filter/import' => 'time_filter#import'
  end

  resources :courses, only: [:index, :show] do
    post 'vote'
  end

  resources :comments, only: [:create, :update, :destroy] do
    post 'vote'
  end

  scope 'courses' do
    post 'title' => 'courses#title'
    post 'instructor' => 'courses#instructor'
  end
  
  #namespace :api do
  #  namespace :v1 do
  #    resources :courses, defaults: { format: 'json' }
  #    resources :departments, defaults: { format: 'json' }
  #  end
  #end
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
