class SubsController < ApplicationController
  # before_action :require_moderator(sub), only: :edit

  def index
    @subs = Sub.all.order("lower(title)")
    render :index
  end

  def show
    @sub = Sub.find_by(id: params[:id])
    render :show
  end

  def new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator = current_user
    if @sub.save

      redirect_to root_url #TODO something different
    else
      flash[:errors] = ["Sub sinking"]
      redirect_to new_sub_url
    end
  end

  def edit
    @sub = Sub.find_by(id: params[:id])

    if @sub.nil?
      redirect_to subs_url
    else
      require_moderator(@sub)
    end
  end

  def update
    @sub = Sub.find_by(id: params[:id])

    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash[:errors] = ["Sub sinking"]
      redirect_to edit_sub_url(@sub)
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description, :user_id)
  end

  def require_moderator(sub)
    if current_user == sub.moderator
      render :edit
    else
      flash[:errors] = ["You are not the Moderator"]
      redirect_to subs_url
    end
  end
end
