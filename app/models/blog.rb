class Blog < ApplicationRecord
	belongs_to :user
	has_rich_text :description

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
