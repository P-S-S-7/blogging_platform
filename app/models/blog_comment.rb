class BlogComment < ApplicationRecord
	belongs_to :user
	belongs_to :blog

	def self.ransackable_attributes(auth_object = nil)
		["blog_id", "content", "created_at", "id", "id_value", "updated_at", "user_id"]
	end

	def self.ransackable_associations(auth_object = nil)
		["blog", "user"]
	end

	validates :content, :presence => true, :length => { :maximum => 250 }
end
