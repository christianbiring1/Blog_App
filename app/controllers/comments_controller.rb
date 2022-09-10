class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def create
    @user = current_user
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]

    if @comment.save
      redirect_to user_post_comments_path(current_user, @comment.post_id)
      flash[:notice] = 'Comment created successfully'
    else
      render :create
      flash[:alert] = 'Comment wasn\'t created'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:notice] = 'comment deleted successfully!'
      redirect_to user_post_path(current_user, @comment.post_id)
    else
      flash[:alert] = 'comment wasn\'t deleted'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
