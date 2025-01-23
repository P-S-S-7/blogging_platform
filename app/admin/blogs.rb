ActiveAdmin.register Blog do
	permit_params :title, :description, :user_id

	actions :all, except: []

	filter :id
	filter :title
	filter :created_at
	filter :updated_at
	filter :user

	index do
		selectable_column
		id_column
		column :title
		column :user
		column :created_at
		column :updated_at
		actions
	end

	show do
		attributes_table_for(resource) do
			row :id
			row :title
			row :description do |blog|
				blog.description.body.to_s
			end
			row :user
			row :created_at
			row :updated_at
		end
	end

	form do |f|
		f.semantic_errors(*f.object.errors.attribute_names)
		f.inputs do
			f.input :title
			f.input :description
			f.input :user, as: :select, collection: User.all.collect { |user| [user.email, user.id] }
		end
		f.actions
	end
end

