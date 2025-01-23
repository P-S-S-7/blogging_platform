Rails.application.routes.draw do
	devise_config = ActiveAdmin::Devise.config
	devise_config[:controllers][:omniauth_callbacks] = 'admin/omniauth_callbacks'
	devise_for :admin_users, devise_config
	ActiveAdmin.routes(self)

	# Defines the root path route ("/")
	root "blogs#index"

	resources :blogs do
		resources :blog_comments, only: [:create, :destroy]
		get 'blog_comments/:id', to: 'blog_comments#destroy', as: 'destroy_blog_comment'
	end

	devise_for :users
end
