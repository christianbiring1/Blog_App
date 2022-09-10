class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: %i[index show new]
  before_action :authenticate_user!, only: %i[new create]

  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    respond_to do |format|
      format.html do
        if @post.save
          redirect_to "/users/#{current_user.id}/posts/#{@post.id}"
          flash[:notice] = 'Post created successfully'
        else
          flash[:alert] = 'the post was not create'
          render :new
        end
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = 'The post has been deleted successfully!'
      redirect_to user_posts_path(current_user)
    else
      flash[:alert] = 'the post was\'nt deleted'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
