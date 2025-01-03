class User < ApplicationRecord

  has_many :memberships, dependent: :destroy
  has_many :organisations, through: :memberships

  validates :name, presence: true
  validates :email, 
  format: { with: URI::MailTo::EMAIL_REGEXP },
  uniqueness: { case_sensitive: false }


  normalizes :name, with: -> (name) { name.strip }
  normalizes :email, with: -> (email) { email.strip.downcase }
end
