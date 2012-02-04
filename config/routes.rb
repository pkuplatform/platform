Platform::Application.routes.draw do

  post "search/index"

  devise_for :users

  mailboxes_for :users
  
  get "home" => "site#home"

  mount Ckeditor::Engine => '/ckeditor'

  post "search" => "search#index"

  resources :feedbacks

  namespace :admin do
    get "forms/index"
    post "forms/edit"
    get "members/index"
    post "members/edit"
    get "groups/index"
    post "groups/edit"
    get "activities/index"
    post "activities/edit"
    post "activities/change_group"
  end

  namespace :form do 
    resources :second_building_applications do 
      member do
        #.../1/approv
        post :approve
        #.../1/reject
        post :reject
      end
    end
  end



  resources :profiles

  resources :user_relations, :only => [:create, :destroy]

  resources :groups do
    resources :albums
    resources :activities
    member do
      get 'join'
      get 'like'
      post 'comment'
      namespace :admin do
        get 'members'
        get 'forms'
        post 'edit_members'
      end
      namespace :form do
        get 'second_building/new' => 'second_building_applications#new'
      end
    end
  end

  resources :activities do
    member do
      get 'join'
      get 'like'
      post 'comment'
      #get 'pictures/new' => 'pictures#new'
      #get 'pictures' => 'pictures#index'
      resources :blogs do
        member do
          post :comment
        end
      end
      resources :pictures do
        member do
          post 'comment'
          get 'show_gallery'
        end
      end
      get 'show_members'
      post 'members/edit' => 'activities#edit_members'
    end
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
  root :to => "site#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
