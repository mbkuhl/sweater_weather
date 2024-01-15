class User < ApplicationRecord
  has_secure_password

  before_create :generate_api_key
  
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }

  def generate_api_key
    self.api_key = SecureRandom.urlsafe_base64
  end
end