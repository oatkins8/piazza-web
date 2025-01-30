class SessionsController < ApplicationController

  def new
  end

  def create
    @session = User.create_session(
      email: sign_in_params[:email],
      password: sign_in_params[:password]
    )

    if @session
      # TODO: store the details in a cookie
      flash[:success] = t(".successful")
      redirect_to root_path, status: :see_other
    else
      flash.now[:danger] = t(".unsuccessful")
      render :new, status: :unprocessable_entity
    end
  end

  private 
    def sign_in_params
      @sign_in_params ||= params.require(:user).permit(:email, :password)
    end
end
