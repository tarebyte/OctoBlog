require 'constraints/authenticated'

OctoBlog::Application.routes.draw do

  constraints(Constraints::Authenticated.new) do
    get '/', to: 'users#show', as: 'authenticated_home'
  end

  root to: 'static_pages#home'

  # Needs to be first!
  match '/auth/:provider/callback', to: 'sessions#create',  via: [:get, :post]
  match '/auth/failure',            to: redirect('/'),      via: :get
  match '/signout',                 to: 'sessions#destroy', via: :get

  match '/members',                 to: 'users#index',      via: :get
  match '/projects',                 to: 'repos#list',      via: :get

  resources 'users', only: [:show], path: '' do
    resources 'repos'
    resources 'repos', only: [:index], path: '' do
      resources 'posts', path: ''
    end
  end
end

