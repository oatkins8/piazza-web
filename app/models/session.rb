class Session < ApplicationRecord
  has_secure_token
  
  belongs_to :user

  def to_h
    {
      user_id: user.id,
      session_id: id,
      session_token: token
    }
  end
end
