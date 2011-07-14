Uifcostumes::Application.routes.draw do

  # Authentication
  devise_for :users
    
  # Nesting notes routes
  resources :organizations, :user, :items do 
    resources :notes
  end
  
  # Other generated routes
  resources :categories
  resources :colors
  resources :locations
  resources :photos
  resources :genders
  resources :request_items
  resources :requests
  
  # Semi-static routes
  match 'home' => 'home#home', :as => :home
  match 'about' => 'home#about', :as => :about
  match 'contact' => 'home#contact', :as => :contact
  match 'policy' => 'home#policy', :as => :policy
  match 'home/search' => 'home#search', :as => :search

  # Other named routes
  match 'notes/destroy/:id' => 'notes#destroy', :as => :delete_note
  match 'userlist' => 'user#index', :as => :user_list
  match 'removephoto/:id' => 'photos#destroy', :as => :remove_photo
  match 'addlistitem/:id' => 'items#add_list_item', :as => :add_list_item
  match 'deleteuser/:id' => 'user#destroy', :as => :destroy_user
  match 'updateuser/:id' => 'user#update', :as => :update_user
  match 'browsesubcategories/:id' => 'items#index', :as => :browse_subcategories
  match 'removefromlist/:id' => 'items#remove_from_list', :as => :remove_from_list
  match 'approveuser/:id' => 'user#approve_user', :as => :approve_user
  match 'rejectuser/:id' => 'user#reject_user', :as => :reject_user
  match 'opencostumes' => 'items#index', :as => :open_costumes

  # Default route
  root :to => 'home#home'

end
