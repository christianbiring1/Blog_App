class LikesController < ApplicationController
  def create
    # @post = Post.find(params[:post_id])
    @like = current_user.likes.new
    @like.post_id = params[:post_id]

    if @like.save
      redirect_to user_post_likes_path(current_user, @like.post_id)
    else
      render :create
    end
  end
end
