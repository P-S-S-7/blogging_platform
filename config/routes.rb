Rails.application.routes.draw do
	# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

	# Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
	# Can be used by load balancers and uptime monitors to verify that the app is live.
	get "up" => "rails/health#show", as: :rails_health_check

	# Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
	# get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
	# get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

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
