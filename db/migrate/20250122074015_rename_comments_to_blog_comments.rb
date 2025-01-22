class RenameCommentsToBlogComments < ActiveRecord::Migration[8.0]
	def change
		rename_table :comments, :blog_comments
	end
end
