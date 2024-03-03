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
  resource :favorite, only: [:create, :destroy]
end
resources :users

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
#cd Trip_history
#rails routes
end
