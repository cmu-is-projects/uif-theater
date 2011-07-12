Uifcostumes::Application.routes.draw do
  
  resources :colors

  # Authentication
  devise_for :users
    
  # Nesting notes routes
  resources :organizations, :user, :items do 
    resources :notes
  end
  
  # Other generated routes
  resources :categories
  resources :locations
  resources :photos
  resources :genders
  
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
  match 'browsesubcategories/:id' => 'items#browse_subcategories', :as => :browse_subcategories

  # Default route
  root :to => 'home#home'

end
