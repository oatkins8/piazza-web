class User < ApplicationRecord

  has_many :memberships, dependent: :destroy
  has_many :organisations, through: :memberships

  has_secure_password

  validates :name, presence: true
  validates :email, 
  format: { with: URI::MailTo::EMAIL_REGEXP },
  uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true, length: { minimum: 8 }


  normalizes :name, with: -> (name) { name.strip }
  normalizes :email, with: -> (email) { email.strip.downcase }
end
