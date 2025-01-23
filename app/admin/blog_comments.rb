ActiveAdmin.register BlogComment do
	permit_params :content, :user_id, :blog_id

	actions :all, except: []

	filter :id
	filter :content
	filter :user
	filter :blog
	filter :created_at
	filter :updated_at

	index do
		selectable_column
		id_column
		column :content
		column :user
		column :blog
		column :created_at
		column :updated_at
		actions
	end

	show do
		attributes_table_for(resource) do
			row :id
			row :content
			row :user
			row :blog
			row :created_at
			row :updated_at
		end
	end

	form do |f|
		f.semantic_errors(*f.object.errors.attribute_names)
		f.inputs do
			f.input :content
			f.input :user
			f.input :blog
		end
		f.actions
	end
end
