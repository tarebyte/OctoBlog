OctoBlog::Application.routes.draw do
  root 'static_pages#home'

  # Needs to be first!
  match '/auth/:provider/callback', to: 'sessions#create',  via: :get
  match '/auth/failure',            to: redirect('/'),      via: :get
  match '/signout',                 to: 'sessions#destroy', via: :get

  # match '/pages/:page',             to: 'static_pages#show', via: :get
  match '/members',                 to: 'users#index',      via: :get

  resources 'users', only: [:show], path: '' do
    resources 'repos', only: [:index], path: '' do
      resources 'posts', path: ''
    end
  end
end

