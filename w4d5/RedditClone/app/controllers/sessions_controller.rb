class SessionsController < ApplicationController

  def new
    render :new # log in page
  end

  def create
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if user
      login_user(user)
      redirect_to root_url
    else
      flash[:errors] = ["Invalid login"]
      redirect_to new_session_url
    end
  end

  def destroy
    current_user.resest_session_token!
    session[:session_token] = nil
    redirect_to root_url
  end
end
