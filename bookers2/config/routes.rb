Rails.application.routes.draw do
  
	devise_for :users, controllers: {
    sessions: "public/sessions",
    registrations: "public/registrations"
  }

  resources :users,only: [:show,:edit,:update,:index] do
    member do
      get 'followers'
      get 'followings'
    end
    resource :relationships, only: [:create, :destroy]
  end
  
  # フォローする
  post 'follow/:id' => 'relationships#follow', as: 'follow' 
  # フォロー外す
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' 
  
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create]
    collection do
       get :category
     end
  end
  get 'search' => 'books#search'

  resources :book_comments, only: [:destroy]
  
  resources :messages, :only => [:create]
  
  resources :rooms, :only => [:create, :show, :index]
  
  resources :groups, :only => [:index, :create, :new, :edit, :update, :show]
  
  resources :group_users, :only => [:create, :destroy]
  
  resources :mails, :only => [:new, :create, :show]

  root 'home#top'
  get 'home/about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
