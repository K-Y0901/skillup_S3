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
  
  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
  
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create]
  end

  resources :book_comments, only: [:destroy]
  
  resources :messages, :only => [:create]
  
  resources :rooms, :only => [:create, :show, :index]

  root 'home#top'
  get 'home/about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
