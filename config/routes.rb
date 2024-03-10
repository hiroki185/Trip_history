Rails.application.routes.draw do

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  namespace :admin do
    root to: "homes#top"
    resources :users, only: [:index, :show, :edit, :update]
    resources :travels, only: [:index, :show, :edit, :update, :destroy] do
    resources :travel_comments, only: [:destroy]
   end
  end

root to: "homes#top"

resources :travels do
  resources :travel_comments, only: [:create, :destroy]
  resource :favorite, only: [:create, :destroy]
      collection do
      get 'search'
    end

end

#ゲストログイン機能
devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
end

#ユーザー関連の機能、フォロー機能、ユーザー検索機能
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    collection do
      get 'search'
    end
  end

  # 退会確認画面
  get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
  # 論理削除用のルーティング
  patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'

resources :chats, only: [:show, :create, :destroy]

get 'tagsearches/search', to: 'tagsearches#search'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
#cd Trip_history
#rails routes
#ssh -i ~/.ssh/practice-aws2.pem ec2-user@18.183.49.74
#mysql -u root -p -h rds-mysql-server.cxgo4cy0wddj.ap-northeast-1.rds.amazonaws.com
end
