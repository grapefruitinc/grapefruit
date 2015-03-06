Grapefruit::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  match "become" => 'admin#become', via: [:get, :post]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  devise_scope :user do
    authenticated :user do
      root 'home#dashboard', as: "authenticated_root"
    end
    unauthenticated :user do
      root 'guest#index'
    end
  end

  get 'about' => 'guest#about'
  get 'tos' => 'guest#tos'
  get 'contact' => 'guest#contact'
  get 'contribute' => 'guest#contribute'
  get 'students' => 'guest#students'
  get 'educators' => 'guest#educators'
  get 'admins' => 'guest#admins'

  devise_for :users, :skip => [:sessions, :passwords, :registrations]

  as :user do

    # sessions
    get 'login' => 'devise/sessions#new', as: :new_user_session
    post 'login' => 'devise/sessions#create', as: :user_session
    delete 'logout' => 'devise/sessions#destroy', as: :destroy_user_session

    # passwords
    get 'forgot' => 'devise/passwords#new', as: :new_user_password
    post 'forgot' => 'devise/passwords#create'
    put 'forgot' => 'devise/passwords#update', as: :user_password
    get 'forgot/change' => 'devise/passwords#edit', as: :edit_user_password

    # registrations
    get   'join' => 'devise/registrations#new',    as: :new_user_registration
    post  'join' => 'devise/registrations#create', as: :user_registration
    get 'cancel'   => 'devise/registrations#cancel', as: :cancel_user_registration
    get 'settings' => 'devise/registrations#edit',   as: :edit_user_registration
    put 'join' => 'devise/registrations#update', as: :update_user_registration

    post 'management_state' => 'home#management_state'

  end

  resources :courses do

    get 'iframe'
    get 'students'
    get 'manage'
    get 'stats'

    get 'gradelist' => 'grades#gradelist'

    resources :assignments do
      resources :submissions
      resources :grades
    end

    resources :assignment_types, only: [:index, :create, :destroy, :update]

    resources :documents, shallow: true

    resources :course_users, only: [:create, :destroy]

    resources :capsules do

      resources :documents, shallow: true

      resources :lectures do
        get :toggle_live
        get :comments
        post :submit_comment
        get :list_comments
        resources :documents, shallow: true
        resources :videos, except: :index do
          resources :video_texts, only: [:new, :create, :index, :update, :destroy]
        end
      end

      resources :problem_sets

    end

    resources :topics, only: [:new, :create, :show, :index, :destroy] do
      resources :replies, only: [:create]
    end

    resources :announcements, except: [:show]

    get 'new_to_class' => 'announcements#new_to_class'
    post 'send_to_class' => 'announcements#send_to_class'

  end

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
