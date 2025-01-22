class AdminUser < ApplicationRecord
	devise :database_authenticatable,
			:recoverable, :rememberable, :validatable, :omniauthable, :validatable

	with_options presence: true do
			validates :email
			validates :provider
			validates :uid, uniqueness: { scope: :provider }
	end

	def password_required?
		return false if provider.present?
		super
	end

	class << self
		def from_omniauth(auth)
			admin_user = where(email: auth.info.email).first || where(auth.slice(:provider, :uid).to_h).first || new

			admin_user.tap do |user|
				user.update(provider: auth.provider, uid: auth.uid, email: auth.info.email)
			end
		end
	end

	def self.ransackable_attributes(auth_object = nil)
		["created_at", "email", "encrypted_password", "id", "id_value"]
	end
end

