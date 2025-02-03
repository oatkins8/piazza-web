module Authentication
  extend ActiveSupport::Concern

  protected

  def sign_in(session)
    cookies.encrypted.permanent[:session] = {
      value: session.to_h
    }
  end  

  private

  def authenticate
    Current.session = authenticate_using_cookie
    Current.user = Current.session&.user
  end

  def authenticate_using_cookie
    session = cookies.encrypted[:session]
    authenticate_using(session&.with_indifferent_access)
  end

  def authenticate_using(data)
    data => {user_id:, session:, token:}

    user = User.find(user_id)
    user.authenticate_session(session, token)
  rescue NoMatchingPatternError, ActiveRecord::RecordNotFound
    nil
  end
end