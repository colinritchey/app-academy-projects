class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )
    if user.nil?
      flash[:error] = ["Incorrect login"]
      render :new
    else
      log_in_user!(user)
      redirect_to user_url(user)
    end
  end

  def destroy
    log_out_user!
    redirect_to new_session_url
  end


  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

end
