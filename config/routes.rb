Platform::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => "registrations" } do
   get 'users/sign_out' => "devise/sessions#destroy"
  end

  get 'site/newsfeeds'
  get "admin/index"

  post "search/index"

  mailboxes_for :users
  
  get "home" => "site#home"

  mount Ckeditor::Engine => '/ckeditor'

  post "search" => "search#index"

  resources :feedbacks

  namespace :admin do
    resources :forms
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

  resources :profiles do
    member do
      get 'like'
    end
  end

  resources :groups do
    collection do
      get 'wall'
    end
    member do
      get 'join'
      get 'like'
      get 'description'
      get 'history'
      get 'organization'
      get 'activities'
      get 'comments'
      get 'members'
      get 'sms' => 'sms#index'
      post 'sms/push' => 'sms#push'
      namespace :admin do
        get 'members'
        get 'forms'
        get 'introduction'
        get 'description'
        get 'history'
        get 'organization'
        post 'members' => 'groups#edit_members'
      end
      namespace :form do
        get 'second_building/new' => 'second_building_applications#new'
      end
    end
    resources :activities
    resources :circles
  end

  resources :activities do
    collection do
      get 'tag_cloud'
      get 'tag'
      get 'wall'
    end
    member do
      get 'join'
      get 'like'
      get 'show_members'
      post 'members/edit' => 'activities#edit_members'
    end
    resources :blogs 

    resources :pictures do
      member do
        get 'show_gallery'
        get 'load'
      end
    end
    resources :albums 
    resources :circles
  end

  resources :comments, :only => [:create, :destroy]

  resources :circles

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
