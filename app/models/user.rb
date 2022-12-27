class User < ApplicationRecord
	before_save { self.email = email.downcase }
	has_many :articles, dependent: :destroy

	VALID_EMAIL_REGEX = /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX  }, 
				uniqueness: {case_sensitive: false}
	validates :username, presence: true, length: { minimum: 2, maximum: 24}, uniqueness: true

	has_secure_password
end
