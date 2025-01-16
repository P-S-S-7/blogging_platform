class User < ApplicationRecord
	has_many :blogs, dependent: :destroy
	normalizes :email, with: ->(e) { e.strip.downcase }
end
