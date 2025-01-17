class User < ApplicationRecord
	has_secure_password
	has_many :blogs, dependent: :destroy
	normalizes :email, with: ->(e) { e.strip.downcase }

	validates :email, :presence => true, :uniqueness => true, :format => { :with => URI::MailTo::EMAIL_REGEXP, :message => "email format invalid" }
end
