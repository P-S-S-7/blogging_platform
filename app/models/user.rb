class User < ApplicationRecord
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

	has_many :blogs, dependent: :destroy
	has_many :blog_comments, dependent: :destroy

	def self.ransackable_attributes(auth_object = nil)
		["id", "name", "email", "created_at", "updated_at"]
	end

	def self.ransackable_associations(auth_object = nil)
		["blogs"]
	end

	normalizes :email, with: ->(mail) { mail.strip.downcase }

	validates :name, :presence => true
	validates :email, :presence => true, 
			:uniqueness => true, 
			:format => { :with => URI::MailTo::EMAIL_REGEXP, :message => "format is invalid" }
end
