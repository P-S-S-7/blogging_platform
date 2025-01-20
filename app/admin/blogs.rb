ActiveAdmin.register Blog do

	# See permitted parameters documentation:
	# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
	#
	# Uncomment all parameters which should be permitted for assignment
	#
	# permit_params :title, :user_id
	#
	# or
	#
	# permit_params do
	#   permitted = [:title, :user_id]
	#   permitted << :other if params[:action] == 'create' && current_user.admin?
	#   permitted
	# end

	permit_params :title, :description, :user_id 

	index do
		selectable_column
		id_column
		column :title
		column :description
		column :user
		actions
	end

	filter :title
	filter :user

	form do |f|
		f.inputs do
			f.input :title
			f.input :description
			f.input :user
		end
		f.actions
	end

	show do
		attributes_table do
			row :title
			row :description
			row :user
			row :created_at
			row :updated_at
		end
	end
end
