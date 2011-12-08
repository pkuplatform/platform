Platform::Application.routes.draw do

  resources :blogs do
    member do
      post :comment
    end
  end

  resources :users do
    member do
      get 'profile/edit' => 'profiles#edit'
      get 'profile' => 'profiles#show'
    end
  end
  
  devise_for :users, :controllers => { 
    :sessions => "sessions",
    :registrations => "registrations"
  }


  mailboxes_for :users
  resources :users do
    member do
    #users/1/liking  他喜欢的人列表
      get :liking, :liked
    end
  end
  
  resources :profiles

  resources :user_relations, :only => [:create, :destroy]

  resources :groups do
    resources :albums
    member do
      get 'join'
      get 'like'
      get 'activities/new' => 'activities#new'
    end
  end

  resources :activities do
    resources :albums
    member do
      get 'join'
      get 'like'
      post 'comment'
      get 'pictures/new' => 'pictures#new'
      get 'pictures' => 'pictures#index'
      get 'blogs/new' => 'blogs#new'
      get 'blogs' => 'blogs#index'
    end
  end

  resources :albums do
    resources :pictures
  end

  resources :pictures do
    member do
      post 'comment'
    end
  end

  namespace :form do 
    resources :booth_application_forms 
    resources :second_building_application_forms
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'users#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
