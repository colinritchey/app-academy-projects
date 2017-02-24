class PostsController < ApplicationController

  def show
    @post = Post.find_by(id: params[:id])
    render :show
  end

  def new
    @subs = Sub.all.order("lower(title)")
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user

    if @post.save
      # postsub_params[:sub_id].each do |sub_id|
      #   Postsub.create(post_id: @post.id, sub_id: sub_id)
      # end

      redirect_to post_url(@post)
    else
      flash[:errors] = ["Invalid post"]
      redirect_to new_post_url
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
    @subs = Sub.all.order("lower(title)")
    render :edit
  end

  def update
    @post = Post.find_by(id: params[:id])

    return if current_user != @post.author

    if @post.update_attributes(post_params)

      # post_subs = Postsub.where(post_id: @post.id)


      # postsub_params[:sub_id].each do |sub_id|
      #   post_sub = Postsub.find_by(post_id: @post.id, sub_id: sub_id)
      #
      #   if post_sub.nil?
      #     #if not created
      #     Postsub.create(post_id: @post.id, sub_id: sub_id)
      #   else
      #     #if already created
      #     post_sub.update_attributes(postsub_params)
      #   end
      # end

      redirect_to post_url(@post)
    else
      flash[:errors] = ["Invalid post"]
      redirect_to new_post_url
    end
  end

  def post_params
    params.require(:post).permit(:title, :content, :url, sub_id: [])
  end

  def postsub_params
    params.require(:postsub).permit(sub_id: [])
  end
end
