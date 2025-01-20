class User < ApplicationRecord
	has_secure_password
	has_many :blogs, dependent: :destroy
	normalizes :email, with: ->(mail) { mail.strip.downcase }

	validates :email, :presence => true, 
			:uniqueness => true, 
			:format => { :with => URI::MailTo::EMAIL_REGEXP, :message => "email format is invalid" }
end
