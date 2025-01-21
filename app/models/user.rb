class User < ApplicationRecord
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

	has_many :blogs, dependent: :destroy
	has_many :comments, dependent: :destroy

	def self.ransackable_attributes(auth_object = nil)
		%w[id name email created_at updated_at]
	end

	def self.ransackable_associations(auth_object = nil)
		%w[blogs]
	end

	normalizes :email, with: ->(mail) { mail.strip.downcase }

	validates :email, :presence => true, 
			:uniqueness => true, 
			:format => { :with => URI::MailTo::EMAIL_REGEXP, :message => "email format is invalid" }
end
