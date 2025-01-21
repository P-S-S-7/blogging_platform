class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :blog

	validates :content, :presence => true, :length => { :maximum => 250 }
end
