TodoList::Application.routes.draw do


  

  get "static_pages/home"

  devise_for :users ,:controllers => { :sessions => "sessions" }

  devise_for :users do
    #Authentication
    get 'signin',  to: 'sessions#new', :as=>:new_user_session
    delete 'signout' => 'sessions#destroy', :as => :destroy_user_session
  end
  resources :users

  resources :tasks

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'static_pages#home'
end
