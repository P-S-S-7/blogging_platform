class Blog < ApplicationRecord
	belongs_to :user
	has_rich_text :description
	has_many :comments, dependent: :destroy

	def self.ransackable_attributes(auth_object = nil)
		["id", "title", "description", "created_at", "updated_at", "user_id"]
	end

	def self.ransackable_associations(auth_object = nil)
		["rich_text_description", "user"]
	end

	validates :title, :presence => true, 
			:length => { :minimum => 10 }, 
			:format => { :with => /\A[a-zA-Z0-9\s]+\z/, :message => "can only contain letters, numbers, and spaces" }
	validate :description_has_at_least_one_line

	private

	def description_has_at_least_one_line
		if description.blank? || description.body.to_plain_text.strip.split("\n").all?(&:blank?)
			errors.add(:description, "must contain at least one non-blank line")
		end
	end
end
