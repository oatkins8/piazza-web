class User < ApplicationRecord

  has_many :memberships, dependent: :destroy
  has_many :organisations, through: :memberships
  has_many :sessions

  def self.create_session(email:, password:)
    user = User.authenticate_by(email: email, password: password)
    user.sessions.create if user.present?
  end

  has_secure_password

  validates :name, presence: true
  validates :email, 
    format: { with: URI::MailTo::EMAIL_REGEXP },
    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }


  normalizes :name, with: -> (name) { name.strip }
  normalizes :email, with: -> (email) { email.strip.downcase }
end
