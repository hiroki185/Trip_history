Rails.application.routes.draw do

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

root to: "homes#top"
resources :travels do
  resources :travel_comments, only: [:create, :destroy]
  resource :favorite, only: [:create, :destroy]

end

devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
end

  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
resources :chats, only: [:show, :create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
#cd Trip_history
#rails routes
end
