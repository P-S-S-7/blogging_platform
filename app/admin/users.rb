ActiveAdmin.register User do
	permit_params :email, :name, :password, :password_confirmation

	actions :all, except: []

	filter :id
	filter :email
	filter :name
	filter :created_at
	filter :updated_at

	index do
		selectable_column
		id_column
		column :email
		column :name
		column :created_at
		column :updated_at
		actions
	end

	show do
		attributes_table_for(resource) do
			row :id
			row :email
			row :name
			row :created_at
			row :updated_at
		end
	end

	form do |f|
		f.semantic_errors(*f.object.errors.attribute_names)
		f.inputs do
			f.input :email
			f.input :name
			f.input :password
			f.input :password_confirmation
		end
		f.actions
	end
end
