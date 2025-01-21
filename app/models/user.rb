class User < ApplicationRecord
	has_many :blogs, dependent: :destroy
	normalizes :email, with: ->(e) { e.strip.downcase }

	validates :email, :presence => true, :format => { :with => /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/, :message => "email format invalid" }
end
