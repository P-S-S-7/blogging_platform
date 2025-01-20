Rails.application.routes.draw do

  ActiveAdmin.routes(self)
	
	# Defines the root path route ("/")
	root "blogs#index"

	# get "/blogs", to: "blogs#index"

	# get "/blogs/new", to: "blogs#new"
	# post "/blogs", to: "blogs#create"

	# get "/blogs/:id", to: "blogs#show"

	# get "/blogs/:id/edit", to: "blogs#edit"
	# patch "/blogs/:id", to: "blogs#update"
	# put "/blogs/:id", to: "blogs#update"

	# delete "/blogs/:id", to: "blogs#destroy"

	resources :blogs

	resources :users, only: [:new, :create]
	get "signup", to: "users#new"

	get "login", to: "sessions#new"
	post "login", to: "sessions#create"
	get "logout", to: "sessions#destroy"
end
