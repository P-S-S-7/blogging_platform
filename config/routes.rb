Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
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

	resources :blogs do
		resources :comments, only: [:create, :destroy]
		get 'comments/:id', to: 'comments#destroy', as: 'destroy_comment'
	end

	devise_for :users
end
