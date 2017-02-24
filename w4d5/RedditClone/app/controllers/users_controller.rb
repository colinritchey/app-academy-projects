class UsersController < ApplicationController

  def index
    render :index
  end

  def new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login_user(@user)
      # render json: @user
      redirect_to root_url
    else
      flash[:errors] = @user.errors.full_messages
      # render json: @user
      redirect_to new_user_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
