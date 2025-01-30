module Authentication
  extend ActiveSupport::Concern

  protected

  def sign_in(session)
    cookies.encrypted.permanent[:session] = {
      value: session.to_h
    }
  end  
end