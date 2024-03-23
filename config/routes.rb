Rails.application.routes.draw do
  #管理者ログインのルート
  namespace :admin do
    get 'search/search'
  end
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

#ユーザーログインのルート
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
#通知機能のルート
  scope module: :public do
    resources :notifications, only: [:index, :destroy]
  end
  
  get "/users/:id/unsubscribe" => "users#unsubscribe", as: "unsubscribe"

  patch "/users/:id/withdrawal" => "users#withdrawal", as: "withdrawal"
  
#管理者のルート
  namespace :admin do
    root to: "homes#top"
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :travels, only: [:index, :show, :edit, :update, :destroy] do
      resources :travel_comments, only: [:destroy]
    end
    get "search" => "search#search"
  end

#トップページのルート
  root to: "homes#top"

#投稿モデルのルート
  resources :travels do
    resources :travel_comments, only: [:create, :destroy]
    resource :favorite, only: [:create, :destroy]
    collection do
      get "search"
    end
  end

#ゲストユーザーのルート
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

#ログインユーザーのルート
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get "followings" => "relationships#followings", as: "followings"
    get "followers" => "relationships#followers", as: "followers"
    member do
      get :favorites
    end
    collection do
      get "search"
    end
  end

#地図機能のルート
  resource :map, only: [:show]

#DM機能のルート
  resources :chats, only: [:show, :create, :destroy]

  get "tagsearches/search", to: "tagsearches#search"
  
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
#rails db:migrate
#rails db:migrate:reset
#cd Trip_history
#rails routes
#ssh -i ~/.ssh/practice-aws2.pem ec2-user@54.238.218.107
#rails s -e production
#kill $(cat tmp/pids/puma.pid)
#mysql -u root -p -h rds-mysql-server.cxgo4cy0wddj.ap-northeast-1.rds.amazonaws.com

#scp -i ~/.ssh/practice-aws2.pem ~/.ssh/id_rsa ec2-user@43.207.61.188:.ssh/id_rsa
#:wq
#rails db:migrate:status
#rm -rf db/migrate/20240311065411_hoge.rb
#touch db/migrate/20190915065320_hoge.rb
#rails db:migrate:down VERSION=20240313030026
#rm -rf db/migrate/
#rails destroy model モデル名