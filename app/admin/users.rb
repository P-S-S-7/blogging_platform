ActiveAdmin.register User do

	# See permitted parameters documentation:
	# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
	#
	# Uncomment all parameters which should be permitted for assignment
	#
	# permit_params :email, :name, :password_digest, :password, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
	#
	# or
	#
	# permit_params do
	#   permitted = [:email, :name, :password_digest, :password, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
	#   permitted << :other if params[:action] == 'create' && current_user.admin?
	#   permitted
	# end

	permit_params :email, :name, :password, :password_confirmation

	index do
		selectable_column
		id_column
		column :email
		column :name
		actions
	end

	filter :email
	filter :name

	form do |f|
		f.inputs do
			f.input :email
			f.input :name
			f.input :password
			f.input :password_confirmation
		end
		f.actions
	end

	show do
		attributes_table do
			row :email
			row :name
			row :created_at
			row :updated_at
		end
	end
end
